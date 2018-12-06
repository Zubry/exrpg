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

  def clear(patches, location) do
    Map.drop(patches, location)
  end

  def check(patches, location) do
    unless Map.has_key?(patches, location) do
      :empty
    else
      Map.get(patches, location) 
    end
  end
end
