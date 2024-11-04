defmodule TestPrivate do
  def double(a), do: sum(a, a)

  defp sum(a, b), do: a + b
end

defmodule Circle do
  @moduledoc "Implements basic circle functions"
  @pi 3.14159

  @doc "Computes the area of a circle"
  @spec area(number) :: number
  def area(r), do: r * r * @pi

  @doc "Computes the circumference of a circle"
  @spec circumference(number) :: number
  def circumference(r), do: 2 * r * @pi
end

defmodule ListHelper do
  def smallest(list) when length(list) > 0 do
    Enum.min(list)
  end

  def smallest(_), do: {:error, :invalid_argument}

  def sum(list) do
    do_sum(0, list)
  end

  defp do_sum(current_sum, []) do
    current_sum
  end

  defp do_sum(current_sum, [head | tail]) do
    new_sum = head + current_sum
    do_sum(new_sum, tail)
  end
end

defmodule NaturalNum do
  def print(1), do: IO.puts(1)

  def print(n) when is_integer(n) and n > 0 do
    IO.puts(n)
    print(n - 1)
  end

  def print(_), do: {:error, :invalid_argument}
end

defmodule TailRecursion do
  # List Len

  def list_len(list) when is_list(list) do
    do_list_len(0, list)
  end

  def list_len(_), do: {:error, :invalid_argument}

  defp do_list_len(len, []) do
    len
  end

  defp do_list_len(len, [_head | tail]) do
    do_list_len(len + 1, tail)
  end

  # Range

  def range(from, to) do
    do_range(from, to, [])
  end

  defp do_range(from, to, result) when from > to do
    result
  end

  defp do_range(from, to, result) do
    do_range(from, to - 1, [to | result])
  end

  # Positive

  def positive(list) when is_list(list) do
    do_positive([], list)
  end

  defp do_positive(list, []) do
    Enum.reverse(list)
  end

  defp do_positive(list, [head | tail]) when head > 0 do
    do_positive([head | list], tail)
  end

  defp do_positive(list, [_head | tail]) do
    do_positive(list, tail)
  end
end

defmodule ZFile do
  def large_lines!(path) do
    path
    |> filtered_lines!()
    |> Enum.filter(&(String.length(&1) > 80))
  end

  def lines_lenghts!(path) do
    path
    |> filtered_lines!()
    |> Stream.with_index()
    |> Enum.each(fn {result, index} ->
      IO.puts("Line: #{index} Length: #{String.length(result)}")
    end)
  end

  def longest_line_length!(path) do
    path
    |> filtered_lines!()
    |> Enum.map(&String.length(&1))
    |> Enum.max()
  end

  def longest_line!(path) do
    path
    |> filtered_lines!()
    |> Enum.max_by(&String.length/1)
  end

  def words_per_line!(path) do
    path
    |> filtered_lines!()
    |> Enum.each(fn string ->
      words = String.split(string)
      IO.puts("#{length(words)} Words: #{Enum.join(words, ", ")}")
    end)
  end

  defp filtered_lines!(path) do
    path
    |> File.stream!()
    |> Stream.map(&String.trim_trailing(&1, "\n"))
  end
end
