# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :acolyte_trials,
  ecto_repos: [AcolyteTrials.Repo]

# Configures the endpoint
config :acolyte_trials, AcolyteTrialsWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "Azb4jmjAavcwL9PXFL3tcfqqxcWwMAKhRHZiCEuOgo1hd2dGkbqCjCDz1+0R275f",
  render_errors: [view: AcolyteTrialsWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: AcolyteTrials.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
