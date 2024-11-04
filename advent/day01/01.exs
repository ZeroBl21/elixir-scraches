defmodule Day1 do
  def start() do
    "./input.txt"
    |> File.stream!()
    |> Stream.map(&String.trim_trailing(&1, "\n"))
    |> Stream.map(&(Integer.floor_div(String.to_integer(&1), 3) - 2))
    |> Enum.reduce(
      0,
      fn x, acc -> x + acc end
    )
    |> IO.inspect()
  end
end

Day1.start()
