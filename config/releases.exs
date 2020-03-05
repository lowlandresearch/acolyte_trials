import Config

config :acolyte_trials, AcolyteTrialsWeb.Endpoint,
  server: true,
  http: [port: {:system, "PORT"}]

url(host: "#{System.get_env("APP_NAME")}.gigalixirapp.com", port: 443)
