defmodule Day02Benchmark do
  def benchmark do
    Benchee.run(%{
      "Using for" => fn -> Day02.part2() end,
      "Using Stream" => fn -> Day02.part2_stream() end
    })
  end
end
