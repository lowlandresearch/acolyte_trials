defmodule AcolyteTrials.Devices.Device do
  use Ecto.Schema
  import Ecto.Changeset

  schema "devices" do
    field :config_hash, :string
    belongs_to :user, AcolyteTrials.Accounts.User

    timestamps()
  end

  @doc false
  def changeset(device, attrs) do
    device
    |> cast(attrs, [:config_hash, :user_id])
    |> validate_required([:config_hash])
    |> unique_constraint(:user_id, message: "User already has a device assigned")
  end
end
