defmodule AcolyteTrialsWeb.UserSocket do
  use Phoenix.Socket

  alias AcolyteTrials.Devices

  ## Channels
  # channel "room:*", AcolyteTrialsWeb.RoomChannel
  channel "devices:*", AcolyteTrialsWeb.DeviceChannel

  # Socket params are passed from the client and can
  # be used to verify and authenticate a user. After
  # verification, you can put default assigns into
  # the socket that will be set for all channels, ie
  #
  #     {:ok, assign(socket, :user_id, verified_user_id)}
  #
  # To deny connection, return `:error`.
  #
  # See `Phoenix.Token` documentation for examples in
  # performing token verification on connect.
  def connect(%{"token" => device_id}, socket, _connect_info) do
    case Devices.get_device_by(config_hash: device_id) do
      %Devices.Device{} ->
        {:ok, assign(socket, :device_id, device_id)}

      _ ->
        :error
    end
  end

  def connect(_params, _socket, _connect_info) do
    :error
  end

  # Socket id's are topics that allow you to identify all sockets for a given user:
  #
  #     def id(socket), do: "user_socket:#{socket.assigns.user_id}"
  #
  # Would allow you to broadcast a "disconnect" event and terminate
  # all active sockets and channels for a given user:
  #
  #     AcolyteTrialsWeb.Endpoint.broadcast("user_socket:#{user.id}", "disconnect", %{})
  #
  # Returning `nil` makes this socket anonymous.
  def id(%{assigns: %{device_id: device_id}}), do: "device_socket:#{device_id}"
  def id(_socket), do: nil
end
