defmodule AcolyteTrials.Channels.UserSocketTest do
  use AcolyteTrialsWeb.ChannelCase, async: true

  alias AcolyteTrialsWeb.UserSocket

  setup do
    device = device_fixture()
    {:ok, device: device}
  end

  test "socket authentication with valid token", %{device: device} do
    assert {:ok, socket} = connect(UserSocket, %{"token" => device.config_hash})
    assert socket.assigns.device_id == device.config_hash
  end

  test "socket authentication with invalid token" do
    assert :error = connect(UserSocket, %{"token" => "123"})
    assert :error = connect(UserSocket, %{})
  end
end
