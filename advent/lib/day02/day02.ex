defmodule Day02 do
  @input "./lib/day02/day02-input.txt"

  def part1(noun \\ 12, verb \\ 2) do
    @input
    |> get_input()
    |> change_input(noun, verb)
    |> run(0)
    |> hd()
  end

  def part2() do
    do_part2()
    |> IO.inspect(label: "Part 2")
  end

  def part2_stream() do
    do_part2_stream()
    |> IO.inspect(label: "Part 2 Stream")
  end

  defp do_part2() do
    for(
      noun <- 0..99,
      verb <- 0..99,
      part1(noun, verb) == 19_690_720,
      do: 100 * noun + verb
    )
    |> hd()
  end

  defp do_part2_stream do
    0..99
    |> Stream.flat_map(fn noun ->
      0..99
      |> Stream.map(fn verb -> {noun, verb} end)
    end)
    |> Stream.filter(fn {noun, verb} -> part1(noun, verb) == 19_690_720 end)
    |> Stream.map(fn {noun, verb} -> 100 * noun + verb end)
    |> Enum.at(0)
  end

  defp run(input, pos) do
    case Enum.fetch(input, pos) do
      {:ok, 99} ->
        input

      {:ok, 1} ->
        instruction(:sum, input, pos)
        |> run(pos + 4)

      {:ok, 2} ->
        instruction(:mul, input, pos)
        |> run(pos + 4)

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

  defp change_input(input, noun, verb) do
    input
    |> List.replace_at(1, noun)
    |> List.replace_at(2, verb)
  end
end

# Day02.part1()
# |> IO.inspect(label: "Part 1")

# Day02.part2()
# Day02.part2_stream()
