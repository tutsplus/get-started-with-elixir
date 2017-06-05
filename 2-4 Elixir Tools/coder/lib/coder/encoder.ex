defmodule Coder.Encoder do
  def encode(text) do
    # Application.get_env(:coder, :prefix) <> String.reverse(text)
    Application.get_env(:coder, __MODULE__)[:prefix] <> String.reverse(text)
  end

  def to_json(data) do
    Poison.encode!(data)
  end
end
