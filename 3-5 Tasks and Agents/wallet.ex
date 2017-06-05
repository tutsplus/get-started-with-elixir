defmodule Wallet do
  def start_link(amount) do
    Agent.start_link(fn -> amount end)
  end

  def put_in(wallet, money) do
    Agent.update(wallet, fn(amount) -> amount + money end)
  end

  def take_out(wallet, money) do
    Agent.update(wallet, fn(amount) -> amount - money end)
  end

  def amount(wallet) do
    Agent.get(wallet, fn(amount) -> amount end)
  end
end
