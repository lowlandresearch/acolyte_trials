defmodule AcolyteTrialsWeb.DeviceChannel do
  use AcolyteTrialsWeb, :channel

  def join("devices:" <> _device_id, _payload, socket) do
    {:ok, socket}
  end
end
