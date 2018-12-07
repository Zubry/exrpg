defmodule Inventory.Model do
  def create do
    %{}
  end

  def add(inventory, name, { item, quantity }) when quantity > 0 do
    inventory
      |> Map.update(name, { item, quantity }, fn ({ item, quantity2 }) ->
        { item, quantity2 + quantity }
      end)
  end

  def remove(inventory, name, quantity) when quantity > 0 do
    if Map.has_key?(inventory, name) do
      Map.get_and_update!(inventory, name, fn ({ item, quantity2 }) ->
        new_quantity = max(quantity2 - quantity, 0)
        {new_quantity, {item, new_quantity}}
      end)
    else
      {0, inventory}
    end
  end

  def drop(inventory, name) do
    Map.delete(inventory, name)
  end

  def has?(inventory, name) do
    Map.has_key?(inventory, name)
  end

  def get(inventory, name) do
    Map.get(inventory, name)
  end
end
