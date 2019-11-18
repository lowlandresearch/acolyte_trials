defmodule AcolyteTrials.TestHelpers do
  alias AcolyteTrials.{Accounts, Devices}

  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        name: "Some User",
        github_username: "user#{System.unique_integer([:positive])}"
      })
      |> Accounts.create_user()

    user
  end

  def device_fixture(attrs \\ %{}) do
    {:ok, device} =
      attrs
      |> Enum.into(%{
        config_hash: "12345678910"
      })
      |> Devices.create_device()

    device
  end
end
