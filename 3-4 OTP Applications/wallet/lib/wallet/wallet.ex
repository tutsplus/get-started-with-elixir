defmodule Wallet.Wallet do
  use GenServer

  alias Wallet.Cache

  def name(wallet) do
    GenServer.call(wallet, :name)
  end

  def amount(wallet) do
    GenServer.call(wallet, :amount)
  end

  def deposit(wallet, amount) do
    GenServer.cast(wallet, {:deposit, amount})
  end

  def withdraw(wallet, amount) do
    GenServer.cast(wallet, {:withdraw, amount})
  end

  # Server API

  def start_link(name) do
    GenServer.start_link(__MODULE__, name)
  end

  def init(name) do
    state = Cache.find(name) || %{name: name, amount: 0}
    {:ok, state}
  end

  def handle_call(:name, _from, state) do
    {:reply, state.name, state}
  end

  def handle_call(:amount, _from, state) do
    {:reply, state.amount, state}
  end

  def handle_cast({:deposit, amount}, state) do
    state = %{state | amount: state.amount + amount}
    Cache.store(state)
    {:noreply, state}
  end

  def handle_cast({:withdraw, amount}, state) do
    state = %{state | amount: state.amount - amount}
    Cache.store(state)
    {:noreply, state}
  end
end
