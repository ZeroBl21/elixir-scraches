defmodule BottleServer do
  def start do
    spawn(&loop/0)
  end

  def send_msg(server, msg) do
    send(server, {self(), msg})

    receive do
      {:response, value} -> value
    end
  end

  defp loop do
    receive do
      {caller, msg} ->
        Process.sleep(1000)
        send(caller, {:response, msg})
    end

    loop()
  end
end
