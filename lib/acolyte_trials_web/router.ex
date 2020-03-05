defmodule AcolyteTrialsWeb.Router do
  use AcolyteTrialsWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
    plug AcolyteTrialsWeb.APIAuthPlug, otp_app: :acolyte_trials
  end

  pipeline :protected do
    plug Pow.Plug.RequireAuthenticated,
      error_handler: AcolyteTrialsWeb.APIAuthErrorHandler
  end

  scope "/api", AcolyteTrialsWeb do
    pipe_through :api

    get "/auth/:provider/new", APIAuthorizationController, :new
    get "/auth/:provider/callback", APIAuthorizationController, :callback

    resources "/session", APISessionController,
      singleton: true,
      only: [:create, :delete]

    post "/session/renew", APISessionController, :renew
  end

  scope "/api", AcolyteTrialsWeb do
    pipe_through [:api, :protected]
  end
end
