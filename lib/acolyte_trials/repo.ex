defmodule AcolyteTrials.Repo do
  use Ecto.Repo,
    otp_app: :acolyte_trials,
    adapter: Ecto.Adapters.Postgres
end
