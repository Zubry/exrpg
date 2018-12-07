defmodule Inventory do
    use Script
    
    mount do
        %{}
    end
    
    on :add, [item, quantity] do
        
    end
    
    on :remove, [item, quantity] do
    
    end
    
    on :has, [item] do
    
    end
    
    on :weight, [] do
    
    end
    
    on :encumbered?, [] do
    
    end
    
    on :full?, [] do
    
    end
end