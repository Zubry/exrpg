defmodule Farming.Supervisor do
  use Supervisor

  def start(_type, _args) do
    Farming.Supervisor.start_link(name: Farming.Supervisor)
  end

  def start_link(opts) do
    Supervisor.start_link(__MODULE__, :ok, opts)
  end

  def init(:ok) do
    children = [
      {Registry, name: Farming.Registry, keys: :unique},
      {DynamicSupervisor, name: Farming.DynamicSupervisor, strategy: :one_for_one}
    ]
    
    Supervisor.init(children, strategy: :one_for_one)
  end
  
  def create(name) do
    DynamicSupervisor.start_child(Farming.DynamicSupervisor, {Farming, name: whereis(name)})
  end
  
  def whereis(name), do: {:via, Registry, {Farming.Registry, name} }
end