defmodule Farming do
  use Script
  
  mount do
    Farming.Patches.create
  end
  
  on :plant, [ location, plant ] do
    Farming.Model.plant(state, location, plant)
  end
  
  on :harvest, [ location ] do
    Farming.Model.harvest(state, location)
  end
  
  on :check, [ location ] do
    Farming.Model.check(state, location)
  end
end