defmodule Farming.Plant do
  @moduledoc """
    Contains little more than a struct to define a farmable plant
  """
  defstruct [
    planted_at: 0,
    growth_cycles: 0,
    cycle_length: 0,
    dies: 0,
    yield: 0
  ]

  @doc """
    Creates a plant according to the specifications.
    Precalculates if the plant will die or not and how much it will yield.
    Accepts a tuple of:
      growth_cycles: The number of cycles it'll take to grow
      cycle_length: The length (in seconds) of each cycle
      hardiness: The chance of the plant surviving each cycle. A hardiness of h implies a chance of surviving a cycle of hardiness / 100
      lives: The number of harvest-lives. Once the number of lives is exhausted, the plant can no longer be harvested
      chance: The chance of losing a harvest-life when the plant is picked
  """
  def create({ growth_cycles, cycle_length, hardiness, lives, chance }) do
    %Farming.Plant{
        planted_at: DateTime.utc_now,
        growth_cycles: growth_cycles,
        cycle_length: cycle_length,
        dies: dies_at(growth_cycles, hardiness),
        yield: yields(lives, chance)
      }
  end

  def check(%{
    planted_at: planted_at,
    growth_cycles: growth_cycles,
    cycle_length: cycle_length,
    dies: dies
  }) do
    cycles = DateTime.utc_now()
      |> DateTime.diff(planted_at)
      |> Kernel./(cycle_length)
      |> trunc
      |> min(growth_cycles)

    if dies != nil and cycles >= dies do
      { :dead, dies }
    else
      { :alive, cycles, cycles == growth_cycles }
    end
  end
  
  def empty?(%Farming.Plant{ yield: 0 }), do: true
  def empty?(%Farming.Plant{ yield: _ }), do: false
  
  def harvest(plant) do
    plant
      |> Map.update(:yield, 0, fn yield -> unless yield < 1, do: yield - 1, else: 0 end)
  end
  
  defp dies_at(growth_cycles, hardiness) do
    # Basically the plant has a chance of dying at each growth cycle.
    # The probability of it dying is (1 - hardiness / 100)
    index = 1..growth_cycles
      |> Enum.map(fn _ -> :rand.uniform(100) >= hardiness end)
      # If it's true, it dies
      |> Enum.find_index(fn x -> x end)
    
    # Just correct for find_index being 0 based
    unless index == nil do
      index + 1
    end
  end
  
  # Basically each plant gets a certain number of lives
  # Each time you go to harvest, you have a chance of losing a life
  # When you run out of lives, that's it, the patch is now empty.
  defp yields(lives, chance, amount \\ 0)
  defp yields(0, _chance, amount), do: amount
  defp yields(lives, chance, amount) do
    if :rand.uniform(100) >= chance do
      yields(lives, chance, amount + 1)
    else
      yields(lives - 1, chance, amount + 1)
    end
  end
end