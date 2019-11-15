defmodule AcolyteTrials.Repo.Migrations.CreateDevices do
  use Ecto.Migration

  def change do
    create table(:devices) do
      add(:config_hash, :string)
      add(:user_id, references(:users, on_delete: :nilify_all))

      timestamps()
    end

    create(unique_index(:devices, [:config_hash]))
    create(unique_index(:devices, [:user_id]))
  end
end
