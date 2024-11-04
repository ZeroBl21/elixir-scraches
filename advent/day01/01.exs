defmodule Day1 do
  def start() do
    "./input.txt"
    |> File.stream!()
    |> Stream.map(&String.trim/1)
    |> Stream.map(&fuel_required/1)
    |> Enum.sum()
    |> IO.inspect(label: "Total Fuel")
  end

  defp fuel_required(fuel) do
    fuel
    |> String.to_integer()
    |> Integer.floor_div(3)
    |> Kernel.-(2)
  end
end

Day1.start()
