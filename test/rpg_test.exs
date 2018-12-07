defmodule RPGTest do
  use ExUnit.Case
  doctest RPG

  test "greets the world" do
    user = Inventory.Supervisor.create(:user)

    :ok = Inventory.add(user, :ranarr_seed, { :ranarr_seed, 1 })
    {:ok, {:ranarr_seed, 1}} = Inventory.get(user, :ranarr_seed)
    :ok = Inventory.remove(user, :ranarr_seed, 1)
    {:ok, nil} = Inventory.get(user, :ranarr_seed)
  end
end
