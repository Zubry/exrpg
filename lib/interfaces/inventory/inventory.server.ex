defmodule Inventory do
  use Script

  mount do
    Inventory.Model.create
  end

  on :add, [name, item] do
    {:ok, Inventory.Model.add(state, name, item)}
  end

  on :remove, [name, quantity] do
    {:ok, Inventory.Model.remove(state, name, quantity)}
  end

  on :drop, [name] do
    {:ok, Inventory.Model.drop(state, name)}
  end

  on :has?, [name] do
    {:ok, Inventory.Model.has?(state, name)}
  end
end
