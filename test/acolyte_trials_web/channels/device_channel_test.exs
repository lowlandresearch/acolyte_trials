defmodule AcolyteTrialsWeb.DeviceChannelTest do
  use AcolyteTrialsWeb.ChannelCase

  alias AcolyteTrialsWeb.UserSocket

  setup do
    device = device_fixture()
    {:ok, socket} = connect(UserSocket, %{"token" => device.config_hash})

    {:ok, socket: socket, device: device}
  end

  test "join devices channel", %{socket: socket, device: device} do
    assert {:ok, _reply, socket} = subscribe_and_join(socket, "devices:#{device.id}")
  end
end
