defmodule PageProducer do
  use GenStage
  require Logger

  @impl true
  def init(initial_state) do
    Logger.info("PageProducer init")

    {:producer, initial_state}
  end

  @impl true
  def handle_demand(demand, state) do
    Logger.info("PageProducer received demand for #{demand} pages")
    events = []

    {:noreply, events, state}
  end

  def scrape_pages(pages) when is_list(pages) do
    ScrapingPipeline
    |> Broadway.producer_names()
    |> List.first()
    |> GenStage.cast({:pages, pages})
  end

  @impl true
  def handle_cast({:pages, pages}, state) do
    {:noreply, pages, state}
  end

  #
end
