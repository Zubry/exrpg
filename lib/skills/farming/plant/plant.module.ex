defmodule Plant do
  @moduledoc """
    Contains little more than a struct to define a farmable plant
  """
  defstruct [
    location: :nowhere,
    planted_at: 0,
    growth_cycles: 0,
    cycle_length: 0,
    dies: 0
  ]

  def plant(location, growth_cycles, cycle_length, hardiness \\ 5) do
      %Plant{
        location: location,
        planted_at: DateTime.utc_now,
        growth_cycles: growth_cycles,
        cycle_length: cycle_length,
        dies: 1..growth_cycles
          |> Enum.map(fn _ -> :rand.uniform(100) <= hardiness end)
          |> Enum.find_index(fn x -> x end)
          |> (&(unless &1 == nil do
            &1 + 1
          end)).()
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
      { :alive, cycles }
    end
  end
end
