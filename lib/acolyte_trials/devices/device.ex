defmodule AcolyteTrials.Devices.Device do
  use Ecto.Schema
  import Ecto.Changeset

  schema "devices" do
    field :config_hash, :string

    timestamps()
  end

  @doc false
  def changeset(device, attrs) do
    device
    |> cast(attrs, [:config_hash])
    |> validate_required([:config_hash])
  end
end
