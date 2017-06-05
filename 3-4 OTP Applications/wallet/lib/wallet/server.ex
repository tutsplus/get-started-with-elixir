defmodule Wallet.Server do
  use Supervisor

  def create_wallet(name) do
    Supervisor.start_child(__MODULE__, [name])
  end

  def find_wallet(name) do
    Enum.find wallets(), fn(child) -> Wallet.Wallet.name(child) == name end
  end

  def delete_wallet(name) do
    case find_wallet(name) do
      nil -> nil
      wallet -> Supervisor.terminate_child(__MODULE__, wallet)
    end
  end

  defp wallets do
    __MODULE__
    |> Supervisor.which_children
    |> Enum.map(fn({_, child, _, _}) -> child end)
  end

  # Supervisor API

  def start_link do
    Supervisor.start_link(__MODULE__, [], name: __MODULE__)
  end

  def init(_) do
    children = [
      worker(Wallet.Wallet, [], restart: :transient)
    ]

    supervise(children, strategy: :simple_one_for_one)
  end
end
