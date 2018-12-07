defmodule Inventory do
  use Script

  mount do
    Inventory.Model.create
  end

  on :add, [name, item] do
    {:ok, Inventory.Model.add(state, name, item)}
  end

  on :remove, [name, quantity] do
    Inventory.Model.remove(state, name, quantity)
      |> case do
        {0, new_state} -> {:ok, Inventory.Model.drop(new_state, name)}
        {_, new_state} -> {:ok, new_state}
      end
  end

  on :drop, [name] do
    {:ok, Inventory.Model.drop(state, name)}
  end

  on :has?, [name] do
    {{:ok, Inventory.Model.has?(state, name)}, state}
  end

  on :get, [name] do
    {{:ok, Inventory.Model.get(state, name)}, state}
  end

  on :all, [] do
    {{:ok, state}, state}
  end
end
