defmodule Farming.Patches do
  def create() do
     %{}
  end

  def add(patches, location, plant) do
    if Map.has_key?(patches, location) do
      {:error, :exists}
    else
      {:ok, Map.put(patches, location, plant)}
    end
  end

  def put(patches, location, plant) do
    Map.put(patches, location, plant)
  end

  def clear(patches, location) do
    Map.delete(patches, location)
  end

  def check(patches, location) do
    unless Map.has_key?(patches, location) do
      :empty
    else
      Map.get(patches, location) 
    end
  end
end
