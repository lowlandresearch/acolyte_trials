defmodule AcolyteTrialsWeb.APIAuthorizationControllerTest do
  use AcolyteTrialsWeb.ConnCase

  @otp_app :acolyte_trials

  defmodule TestProvider do
    @moduledoc false
    @behaviour Assent.Strategy

    @impl true
    def authorize_url(_config),
      do:
        {:ok,
         %{
           url: "https://provider.example.com/oauth/authorize",
           session_params: %{a: 1}
         }}

    @impl true
    def callback(_config, %{"code" => "valid"}),
      do:
        {:ok,
         %{
           user: %{"sub" => 1, "email" => "test@example.com"},
           token: %{"access_token" => "access_Token"}
         }}

    def callback(_config, _params), do: {:error, "Invalid params"}
  end

  setup do
    Application.put_env(@otp_app, :pow_assent,
      providers: [
        test_provider: [strategy: TestProvider]
      ]
    )

    :ok
  end

  describe "new/2" do
    test "with valid config", %{conn: conn} do
      conn =
        get(conn, Routes.api_authorization_path(conn, :new, :test_provider))

      assert json = json_response(conn, 200)

      assert json["data"]["url"] ==
               "https://provider.example.com/oauth/authorize"

      assert json["data"]["session_params"] == %{"a" => 1}
    end
  end

  describe "callback/2" do
    @valid_params %{"code" => "valid", "session_params" => %{"a" => 1}}
    @invalid_params %{"code" => "invalid", "session_params" => %{"a" => 2}}

    test "with valid params", %{conn: conn} do
      conn =
        get(
          conn,
          Routes.api_authorization_path(
            conn,
            :callback,
            :test_provider,
            @valid_params
          )
        )

      assert json = json_response(conn, 200)
      assert json["data"]["token"]
      assert json["data"]["renew_token"]
    end

    test "with invalid params", %{conn: conn} do
      conn =
        get(
          conn,
          Routes.api_authorization_path(
            conn,
            :callback,
            :test_provider,
            @invalid_params
          )
        )

      assert json = json_response(conn, 500)
      assert json["error"]["message"] == "An unexpected error occurred"
      assert json["error"]["status"] == 500
    end
  end
end
