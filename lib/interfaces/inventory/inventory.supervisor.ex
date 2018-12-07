defmodule Inventory.Supervisor do
  use Supervisor

  def start(_type, _args) do
    Inventory.Supervisor.start_link(name: Inventory.Supervisor)
  end

  def start_link(opts) do
    Supervisor.start_link(__MODULE__, :ok, opts)
  end

  def init(:ok) do
    children = [
      {Registry, name: Inventory.Registry, keys: :unique},
      {DynamicSupervisor, name: Inventory.DynamicSupervisor, strategy: :one_for_one}
    ]

    Supervisor.init(children, strategy: :one_for_one)
  end

  def create(name) do
    DynamicSupervisor.start_child(Inventory.DynamicSupervisor, {Inventory, name: whereis(name)})
    whereis(name)
  end

  def whereis(name), do: {:via, Registry, {Inventory.Registry, name} }
end
