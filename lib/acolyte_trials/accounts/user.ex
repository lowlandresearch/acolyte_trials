defmodule AcolyteTrials.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query

  alias AcolyteTrials.Accounts.User

  schema "users" do
    field :name, :string
    field :github_username, :string

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :github_username])
    |> validate_required([:name, :github_username])
  end

  def alphabetical(query) do
    from c in query, order_by: c.name
  end
end
