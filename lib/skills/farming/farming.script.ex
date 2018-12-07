# require Script

# Script.server Farming do
#   did_mount do
#     Farming.Patches.create
#   end
  
#   on plant(state, location, plant) do
#     Farming.Model.plant(state, location, plant)
#   end
  
#   on harvest(state, location) do
#     Farming.Model.harvest(state, location)
#   end
  
#   on check(state, location) do
#     Farming.Model.plant(state, location)
#   end
# end

# defmodule FarmingScript do
#     use Script
    
#     mount do
#         Farming.Patches.create
#     end
    
#     on :plant, [ location, plant ] do
#         Farming.Model.plant(state, location, plant)
#     end
    
#     on :harvest, [ location ] do
#         Farming.Model.harvest(state, location)
#     end
    
#     on :check, [ location ] do
#         Farming.Model.check(state, location)
#     end
# end