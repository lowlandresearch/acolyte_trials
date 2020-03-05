# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :acolyte_trials,
  ecto_repos: [AcolyteTrials.Repo]

# Configures the endpoint
config :acolyte_trials, AcolyteTrialsWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base:
    "7kJfv7YTILGjY40NdMJC/YAfmIVY+tIBWivXOby4m6pK9tnjR/6a4n/RpvHorKuW",
  render_errors: [view: AcolyteTrialsWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: AcolyteTrials.PubSub, adapter: Phoenix.PubSub.PG2],
  live_view: [signing_salt: "pg7qB8FU"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :acolyte_trials, :pow,
  user: AcolyteTrials.Users.User,
  repo: AcolyteTrials.Repo

config :acolyte_trials, :pow_assent,
  http_adapter: Assent.HTTPAdapter.Mint,
  providers: [
    github: [
      client_id: System.get_env("GITHUB_CLIENT_ID"),
      client_secret: System.get_env("GITHUB_CLIENT_SECRET"),
      strategy: Assent.Strategy.Github
    ]
  ]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
