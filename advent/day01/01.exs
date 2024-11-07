defmodule Day1 do
  def start() do
    "./input.txt"
    |> File.stream!()
    |> Stream.map(&String.trim/1)
    |> Stream.map(&String.to_integer/1)
    |> Stream.map(&total_fuel_per_module/1)
    |> Enum.sum()
    |> IO.inspect(label: "Total Fuel")
  end

  defp total_fuel_per_module(mass), do: fuel_for_mass(mass, 0)

  defp fuel_for_mass(mass, acc) when mass <= 0, do: acc

  defp fuel_for_mass(mass, acc) do
    fuel =
      mass
      |> Integer.floor_div(3)
      |> Kernel.-(2)

    fuel_for_mass(max(fuel, 0), acc + max(fuel, 0))
  end
end

Day1.start()
