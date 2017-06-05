defmodule PingPong do
  def start(local, remote) do
    local = Node.spawn_link(local, __MODULE__, :pingpong, [])
    remote = Node.spawn_link(remote, __MODULE__, :pingpong, [])

    send remote, {:ping, local}
  end

  def pingpong do
    receive do
      {:ping, node} ->
        IO.puts "Ping Ping!"
        :timer.sleep(1000)
        send node, {:pong, self()}
      {:pong, node} ->
        IO.puts "Pong Pong!"
        :timer.sleep(1000)
        send node, {:ping, self()}
    end
    pingpong()
  end
end
