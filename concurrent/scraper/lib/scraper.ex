defmodule Scraper do
  def work() do
    # Web Scrapping Simulation

    1..5
    |> Enum.random()
    |> :timer.seconds()
    |> Process.sleep()
  end
end
