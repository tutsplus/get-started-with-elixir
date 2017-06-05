defmodule Fibonacci do
  def fib_list(list) do
    list
    |> Enum.map(&spawn_calculation(&1, self()))
    |> Enum.map(&collect_results/1)
  end

  def fib(n), do: fib(0, 1, n)
  def fib(a, _, 0), do: a
  def fib(a, b, n), do: fib(b, a + b, n - 1)

  defp spawn_calculation(n, parent) do
    spawn_link fn -> send parent, {self(), fib(n)} end
  end

  defp collect_results(pid) do
    receive do
      {^pid, result} -> result
    end
  end
end
