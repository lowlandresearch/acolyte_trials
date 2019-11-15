defmodule AcolyteTrialsWeb.DeviceControllerTest do
  use AcolyteTrialsWeb.ConnCase

  alias AcolyteTrials.Devices

  @create_attrs %{config_hash: "some config_hash"}
  @update_attrs %{config_hash: "some updated config_hash"}
  @invalid_attrs %{config_hash: nil}

  def fixture(:device) do
    {:ok, device} = Devices.create_device(@create_attrs)
    device
  end

  describe "index" do
    test "lists all devices", %{conn: conn} do
      conn = get(conn, Routes.device_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Devices"
    end
  end

  describe "new device" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.device_path(conn, :new))
      assert html_response(conn, 200) =~ "New Device"
    end
  end

  describe "create device" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.device_path(conn, :create), device: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.device_path(conn, :show, id)

      conn = get(conn, Routes.device_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Device"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.device_path(conn, :create), device: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Device"
    end
  end

  describe "edit device" do
    setup [:create_device]

    test "renders form for editing chosen device", %{conn: conn, device: device} do
      conn = get(conn, Routes.device_path(conn, :edit, device))
      assert html_response(conn, 200) =~ "Edit Device"
    end
  end

  describe "update device" do
    setup [:create_device]

    test "redirects when data is valid", %{conn: conn, device: device} do
      conn = put(conn, Routes.device_path(conn, :update, device), device: @update_attrs)
      assert redirected_to(conn) == Routes.device_path(conn, :show, device)

      conn = get(conn, Routes.device_path(conn, :show, device))
      assert html_response(conn, 200) =~ "some updated config_hash"
    end

    test "renders errors when data is invalid", %{conn: conn, device: device} do
      conn = put(conn, Routes.device_path(conn, :update, device), device: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Device"
    end
  end

  describe "delete device" do
    setup [:create_device]

    test "deletes chosen device", %{conn: conn, device: device} do
      conn = delete(conn, Routes.device_path(conn, :delete, device))
      assert redirected_to(conn) == Routes.device_path(conn, :index)

      assert_error_sent 404, fn ->
        get(conn, Routes.device_path(conn, :show, device))
      end
    end
  end

  defp create_device(_) do
    device = fixture(:device)
    {:ok, device: device}
  end
end
