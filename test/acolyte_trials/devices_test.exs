defmodule AcolyteTrials.DevicesTest do
  use AcolyteTrials.DataCase

  alias AcolyteTrials.Devices

  describe "devices" do
    alias AcolyteTrials.Devices.Device

    @valid_attrs %{config_hash: "some config_hash"}
    @update_attrs %{config_hash: "some updated config_hash"}
    @invalid_attrs %{config_hash: nil}

    test "list_devices/0 returns all devices" do
      device = device_fixture()
      retrieved_devices = Devices.list_devices()

      assert retrieved_devices != []

      retrieved_device = hd(retrieved_devices)
      assert retrieved_device.id == device.id
    end

    test "get_device!/1 returns the device with given id" do
      device = device_fixture()
      retrieved_device = Devices.get_device!(device.id)
      assert retrieved_device.id == device.id
    end

    test "get_device_by/1 returns the device with given param" do
      device = device_fixture(@valid_attrs)
      retrieved_device = Devices.get_device_by(@valid_attrs)
      assert retrieved_device.id == device.id
    end

    test "create_device/1 with valid data creates a device" do
      assert {:ok, %Device{} = device} = Devices.create_device(@valid_attrs)
      assert device.config_hash == "some config_hash"
    end

    test "create_device/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Devices.create_device(@invalid_attrs)
    end

    test "update_device/2 with valid data updates the device" do
      device = device_fixture()
      assert {:ok, %Device{} = device} = Devices.update_device(device, @update_attrs)
      assert device.config_hash == "some updated config_hash"
    end

    test "update_device/2 with invalid data returns error changeset" do
      device = device_fixture()
      assert {:error, %Ecto.Changeset{}} = Devices.update_device(device, @invalid_attrs)

      retrieved_device = Devices.get_device!(device.id)
      assert retrieved_device.id == device.id
    end

    test "delete_device/1 deletes the device" do
      device = device_fixture()
      assert {:ok, %Device{}} = Devices.delete_device(device)
      assert_raise Ecto.NoResultsError, fn -> Devices.get_device!(device.id) end
    end

    test "change_device/1 returns a device changeset" do
      device = device_fixture()
      assert %Ecto.Changeset{} = Devices.change_device(device)
    end
  end
end
