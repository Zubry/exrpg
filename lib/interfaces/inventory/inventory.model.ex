defmodule Inventory.Model do


  def add(inventory, name, { item, quantity }) when quantity > 0 do
    inventory
      |> Map.update(name, { item, quantity }, fn ({ item, quantity2 }) ->
        { item, quantity2 + quantity }
      end)
  end

  def remove(inventory, name, quantity) when quantity > 0 do
    if map.has_key?(inventory, name) do
      Map.update!(inventory, name, fn ({ item, quantity2 }) ->
        { item, quantity2 - quantity }
      end)
    else
      inventory
    end
  end

  def drop(inventory, name) do
    Map.delete(inventory, name)
  end

  def has(inventory, name) do
    Map.has_key?(inventory, name)
  end
end
