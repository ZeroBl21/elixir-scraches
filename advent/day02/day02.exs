defmodule Day02 do
  @input "./day02-input.txt"
  # @input "./test.txt"

  def part1() do
    @input
    |> get_input()
    |> replace_part1()
    |> run(0)
    |> IO.puts()
  end

  def run(input, pos) do
    case Enum.fetch(input, pos) do
      {:ok, 99} ->
        IO.inspect(input, label: "El Array Final")
        Enum.at(input, 0)

      {:ok, 1} ->
        new_input = instruction(:sum, input, pos)
        run(new_input, pos + 4)

      {:ok, 2} ->
        new_input = instruction(:mul, input, pos)
        run(new_input, pos + 4)

      _ ->
        IO.puts("Unknown opcode or error")
    end
  end

  defp instruction(:sum, code, pos) do
    [index1, index2, target_index] = Enum.slice(code, pos + 1, 3)

    value1 = Enum.at(code, index1)
    value2 = Enum.at(code, index2)

    List.replace_at(code, target_index, value1 + value2)
  end

  defp instruction(:mul, code, pos) do
    [index1, index2, target_index] = Enum.slice(code, pos + 1, 3)

    value1 = Enum.at(code, index1)
    value2 = Enum.at(code, index2)

    List.replace_at(code, target_index, value1 * value2)
  end

  defp get_input(path) do
    path
    |> File.read!()
    |> String.trim()
    |> String.split(",")
    |> Enum.map(&String.to_integer/1)
  end

  defp replace_part1(input) do
    input
    |> List.replace_at(1, 12)
    |> List.replace_at(2, 2)
  end
end

Day02.part1()
