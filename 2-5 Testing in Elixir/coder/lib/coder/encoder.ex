defmodule Coder.Encoder do
  @doc """
  Encodes a string by reversing it

  ## Examples

    iex>Coder.Encoder.encode("Hello Elixir!")
    "!rixilE olleH"
  """
  def encode(text) do
    # Application.get_env(:coder, :prefix) <> String.reverse(text)
    # Application.get_env(:coder, __MODULE__)[:prefix] <> String.reverse(text)
    String.reverse(text)
  end

  @doc """
  Encodes a map by transforming it to a JSON String

  ## Examples

    iex>Coder.Encoder.to_json(%{name: "Get Started With Elixir", author: "Markus Mühlberger"})
    "{\\\"name\\\":\\\"Get Started With Elixir\\\",\\\"author\\\":\\\"Markus Mühlberger\\\"}"
  """
  def to_json(data) do
    Poison.encode!(data)
  end
end
