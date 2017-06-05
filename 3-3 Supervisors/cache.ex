defmodule Cache do
  use GenServer

  def start_link(opts \\ []) do
    GenServer.start_link(__MODULE__, [], opts)
  end

  def read(key) do
    GenServer.call(__MODULE__, {:read, key})
  end

  def write(key, value) do
    GenServer.cast(__MODULE__, {:write, key, value})
  end

  def init(_) do
    table = :ets.new(:wallet_store, [:set, :protected])
    {:ok, table}
  end

  def handle_call({:read, key}, _, table) do
    value = case :ets.lookup(table, key) do
      [{_, value}] -> value
      _ -> 0
    end
    {:reply, value, table}
  end

  def handle_cast({:write, key, value}, table) do
    :ets.insert(table, {key, value})
    {:noreply, table}
  end
end
