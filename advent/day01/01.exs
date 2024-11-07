defmodule Day1 do
  def start() do
    "./input.txt"
    |> File.stream!()
    |> Stream.map(&String.trim/1)
    |> Stream.map(&fuel_required(&1))
    |> Enum.sum()
    |> IO.inspect(label: "Total Fuel")
  end

  defp fuel_required(fuel) when is_binary(fuel) do
    fuel
    |> String.to_integer()
    |> calculate_total_fuel()
  end

  defp fuel_required(fuel) do
    fuel
    |> Integer.floor_div(3)
    |> Kernel.-(2)
  end

  defp calculate_total_fuel(mass) do
    calculate_fuel(mass, 0)
  end

  defp calculate_fuel(fuel, acc) when fuel <= 0, do: acc

  defp calculate_fuel(mass, total) do
    fuel = fuel_required(mass)

    if fuel > 0 do
      calculate_fuel(fuel, total + fuel)
    else
      total
    end
  end
end

Day1.start()
