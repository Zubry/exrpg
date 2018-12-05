defmodule RPG do
  @moduledoc """
  Documentation for RPG.
  """

  @doc """
  Hello world.

  ## Examples

      iex> RPG.hello
      :world

  """
  def get_plant() do
    Plant.plant(:catherby, 3, 45, 50) 
  end
end
