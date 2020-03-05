defmodule AcolyteTrialsWeb.APISessionControllerTest do
  use AcolyteTrialsWeb.ConnCase

  alias AcolyteTrials.{Repo, Users.User}
  alias AcolyteTrialsWeb.APIAuthPlug
  alias Pow.Ecto.Schema.Password

  @pow_config [otp_app: :acolyte_trials]

  setup do
    user =
      Repo.insert!(%User{
        email: "test@example.com",
        password_hash: Password.pbkdf2_hash("secret1234")
      })

    {:ok, user: user}
  end

  describe "renew/2" do
    setup %{conn: conn, user: user} do
      {authed_conn, _user} = APIAuthPlug.create(conn, user, @pow_config)

      :timer.sleep(100)

      {:ok, renew_token: authed_conn.private[:api_renew_token]}
    end

    test "with valid authorization header", %{conn: conn, renew_token: token} do
      conn =
        conn
        |> Plug.Conn.put_req_header("authorization", token)
        |> post(Routes.api_session_path(conn, :renew))

      assert json = json_response(conn, 200)
      assert json["data"]["token"]
      assert json["data"]["renew_token"]
    end

    test "with invalid authorization header", %{conn: conn} do
      conn =
        conn
        |> Plug.Conn.put_req_header("authorization", "invalid")
        |> post(Routes.api_session_path(conn, :renew))

      assert json = json_response(conn, 401)

      assert json["error"]["message"] == "Invalid token"
      assert json["error"]["status"] == 401
    end
  end

  describe "delete/2" do
    setup %{conn: conn, user: user} do
      {authed_conn, _user} = APIAuthPlug.create(conn, user, @pow_config)

      :timer.sleep(100)

      {:ok, auth_token: authed_conn.private[:api_auth_token]}
    end

    test "invalidates", %{conn: conn, auth_token: token} do
      conn =
        conn
        |> Plug.Conn.put_req_header("authorization", token)
        |> delete(Routes.api_session_path(conn, :delete))

      assert json_response(conn, 200)
      :timer.sleep(100)

      assert {_conn, nil} = APIAuthPlug.fetch(conn, @pow_config)
    end
  end
end
