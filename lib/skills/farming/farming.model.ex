defmodule Farming.Model do
    def plant(state, location, plant) do
      state
        |> Farming.Patches.add(location, Farming.Plant.create(plant))
        |> case do
          {:error, code} -> {{:error, code}, state}
          {:ok, new_state} -> {{:ok}, new_state}
        end
    end
    
    def harvest(state, location) do
      # Get the contents of the patch at the location
      patch = Farming.Patches.check(state, location)
      
      # Get the status of the plant in the patch
      plant = case patch do
        :empty -> :empty
        plant -> Farming.Plant.check(plant)
      end
      
      case plant do
        # Can't harvest an empty patch
        :empty -> {{:error, :empty}, state}
        # or a dead one
        {:dead, _} -> {{:error, :dead}, state}
        {:alive, _, false} -> {{:error, :growing}, state}
        {:alive, _, true} ->
          new_patch = Farming.Plant.harvest(patch)
          
          # Remove the plant from the patch if it's empty
          if Farming.Plant.empty?(new_patch) do
            {{:ok}, Farming.Patches.clear(state, location)}
          else
            {{:ok}, Farming.Patches.put(state, location, new_patch)}
          end
      end
    end
    
    def check(state, location) do
      # Get the contents of the patch at the location
      patch = Farming.Patches.check(state, location)
      
      # Get the status of the plant in the patch
      case patch do
        :empty -> {{:error, :empty}, state}
        plant -> {{:ok, Farming.Plant.check(plant)}, state}
      end
    end
end