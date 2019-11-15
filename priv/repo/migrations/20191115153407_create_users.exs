defmodule AcolyteTrials.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add(:name, :string)
      add(:github_username, :string)

      timestamps()
    end

    create(unique_index(:users, [:github_username]))
  end
end
