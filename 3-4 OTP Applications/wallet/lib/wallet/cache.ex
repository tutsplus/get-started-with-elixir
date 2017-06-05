defmodule Wallet.Cache do
  use GenServer

  def store(wallet) do
    :ets.insert(__MODULE__, {String.to_atom(wallet.name), wallet})
  end

  def find(name) do
    case :ets.lookup(__MODULE__, String.to_atom(name)) do
      [{_id, value}] -> value
      [] -> nil
    end
  end

  def clear do
    :ets.delete_all_objects(__MODULE__)
  end

  # Server API

  def start_link do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def init(_) do
    table = :ets.new(__MODULE__, [:named_table, :public])
    {:ok, table}
  end
end
