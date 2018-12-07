defmodule Script do
    @doc false
    defmacro __using__(_opts) do
        quote do
            import Script
        end
    end
    
    defmacro on(f, args, do: block) do
        quote do
            def unquote(:"#{f}")(server, unquote_splicing(args)) do
                GenServer.call(server, { unquote(f), unquote_splicing(args) })
            end
            
            def handle_call({ unquote(f), unquote_splicing(args) }, var!(_from), var!(state)) do
                { status, new_state } = unquote(block)
                
                {:reply, status, new_state}
            end
        end
    end
    
    defmacro mount(do: block) do
        quote do
            use GenServer
            
            def start_link(opts) do
                GenServer.start_link(__MODULE__, :ok, opts)
            end
            
            def init(:ok) do
                {:ok, unquote(block)}
            end
        end
    end
end