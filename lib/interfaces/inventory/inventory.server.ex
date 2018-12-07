defmodule Inventory do
    use Script

    mount do
        %{}
    end

    on :add, [{item, quantity}] do

    end

    on :remove, [name, quantity] do

    end

    on :drop, [name] do

    end

    on :has, [name] do

    end
end
