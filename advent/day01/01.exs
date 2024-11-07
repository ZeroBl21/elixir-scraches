defmodule Day01 do
  @input "./input.txt"

  def part1() do
    @input
    |> get_input()
    |> Stream.map(&fuel_required/1)
    |> Enum.sum()
    |> IO.inspect(label: "Total Fuel for Part 1")
  end

  def part2() do
    @input
    |> get_input()
    |> Stream.map(&total_fuel_per_module/1)
    |> Enum.sum()
    |> IO.inspect(label: "Total Fuel for Part 2")
  end

  defp get_input(path) do
    path
    |> File.stream!()
    |> Stream.map(&String.trim/1)
    |> Stream.map(&String.to_integer/1)
  end

  defp fuel_required(mass) do
    mass
    |> Integer.floor_div(3)
    |> Kernel.-(2)
    |> max(0)
  end

  defp total_fuel_per_module(mass) do
    fuel_for_mass(mass, 0)
  end

  defp fuel_for_mass(mass, acc) when mass <= 0, do: acc

  defp fuel_for_mass(mass, acc) do
    fuel = fuel_required(mass)
    fuel_for_mass(fuel, acc + fuel)
  end
end

Day01.part1()
Day01.part2()
