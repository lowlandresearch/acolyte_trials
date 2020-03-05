defmodule AcolyteTrialsWeb.APIAuthorizationController do
  use AcolyteTrialsWeb, :controller

  alias Plug.Conn
  alias PowAssent.Plug

  @spec new(Conn.t(), map()) :: Conn.t()
  def new(conn, %{"provider" => provider}) do
    conn
    |> Plug.authorize_url(provider, redirect_uri(conn))
    |> case do
      {:ok, url, conn} ->
        json(conn, %{
          data: %{
            url: url,
            session_params: conn.private[:pow_assent_session_params]
          }
        })

      {:error, _error} ->
        conn
        |> put_status(500)
        |> json(%{
          error: %{status: 500, message: "An unexpected error occurred"}
        })
    end
  end

  defp redirect_uri(conn) do
    "http://localhost:4000/api/auth/#{conn.params["provider"]}/callback"
  end

  @spec callback(Conn.t(), map()) :: Conn.t()
  def callback(conn, %{"provider" => provider} = params) do
    session_params = %{session_params: Map.take(params, ["state"])}
    params = Map.drop(params, ["provider", "state"])

    conn
    |> Conn.put_private(:pow_assent_session_params, session_params)
    |> Plug.callback_upsert(provider, params, redirect_uri(conn))
    |> case do
      {:ok, conn} ->
        json(conn, %{
          data: %{
            token: conn.private[:api_auth_token],
            renew_token: conn.private[:api_renew_token]
          }
        })

      {:error, conn} ->
        conn
        |> put_status(500)
        |> json(%{
          error: %{status: 500, message: "An unexpected error occurred"}
        })
    end
  end
end
