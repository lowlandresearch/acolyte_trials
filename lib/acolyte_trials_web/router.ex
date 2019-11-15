defmodule AcolyteTrialsWeb.Router do
  use AcolyteTrialsWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", AcolyteTrialsWeb do
    pipe_through :browser

    get "/", PageController, :index

    resources "/devices", DeviceController,
      only: [:index, :show, :new, :create, :edit, :update, :delete]

    resources "/users", UserController,
      only: [:index, :show, :new, :create, :edit, :update, :delete]
  end

  # Other scopes may use custom stacks.
  # scope "/api", AcolyteTrialsWeb do
  #   pipe_through :api
  # end
end
