defmodule RPG do
  use Application

  def start(_type, _args) do
    children = [
      Farming.Supervisor,
      Inventory.Supervisor
    ]
    Supervisor.start_link(children, strategy: :one_for_one)
  end
end
