defmodule Farming do
  use GenServer

  ## Client API
  @doc """
    Starts the farming server
  """
  def start_link(opts) do
    GenServer.start_link(__MODULE__, :ok, opts)
  end

  @doc """
    Plants the plant in the requested patch
  """
  def plant(server, location, plant) do
    server
      |> GenServer.call({ :plant, location, plant })
  end
  
  @doc """
    Harvests the plant
  """
  def harvest(server, location) do
    server
      |> GenServer.call({ :harvest, location })
  end

  @doc """
    Checks the growth status of the plant
  """
  def check(server, location) do
    server
      |> GenServer.call({ :check, location })
  end

  ## Server callbacks
  def init(:ok) do
    {:ok, Farming.Patches.create}
  end

  @doc """
    Plant the seed.
    We expect to be given a valid location.
    This may need to be validated at some point.
  """
  def handle_call({ :plant, location, plant }, _from, state) do
    { status, new_state } = Farming.Model.plant(state, location, plant)
    
    {:reply, status, new_state}
  end
  
  def handle_call({ :harvest, location }, _from, state) do
    { status, new_state } = Farming.Model.harvest(state, location)
    
    {:reply, status, new_state}
  end

  @doc """
    Checks the growth status of the plant
  """
  def handle_call({ :check, location }, _from, state) do
    { status, new_state } = Farming.Model.check(state, location)
    
    {:reply, status, new_state}
  end
end
