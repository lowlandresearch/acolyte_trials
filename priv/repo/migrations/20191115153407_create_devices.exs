defmodule AcolyteTrials.Repo.Migrations.CreateDevices do
  use Ecto.Migration

  def change do
    create table(:devices) do
      add(:config_hash, :string)

      timestamps()
    end

    create(unique_index(:devices, [:config_hash]))
  end
end
