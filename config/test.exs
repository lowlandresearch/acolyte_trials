import Config

# Configure your database
config :acolyte_trials, AcolyteTrials.Repo,
  username: "postgres",
  password: "postgres",
  database: "acolyte_trials_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :acolyte_trials, AcolyteTrialsWeb.Endpoint,
  http: [port: 8080],
  https: [
    port: 8443,
    cipher_suite: :strong,
    keyfile: "priv/cert/selfsigned_key.pem",
    certfile: "priv/cert/selfsigned.pem"
  ],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn
