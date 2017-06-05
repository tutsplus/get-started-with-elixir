defmodule Wallet do
  use GenServer

  def start_link(name) do
    GenServer.start_link(__MODULE__, name, [name: name])
  end

  def put_in(wallet, money) do
    GenServer.cast(wallet, {:put_in, money})
  end

  def take_out(wallet, money) do
    GenServer.cast(wallet, {:take_out, money})
  end

  def amount(wallet) do
    GenServer.call(wallet, :amount)
  end

  # Server API

  def init(name) do
    {:ok, name}
  end

  def handle_cast({:put_in, money}, name) do
    amount = Cache.read(name)
    Cache.write(name, amount + money)
    {:noreply, name}
  end

  def handle_cast({:take_out, money}, name) do
    amount = Cache.read(name)
    Cache.write(name, amount - money)
    {:noreply, name}
  end

  def handle_call(:amount, _, name) do
    {:reply, Cache.read(name), name}
  end
end
