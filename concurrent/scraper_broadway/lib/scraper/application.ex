defmodule Scraper.Application do
  use Application

  @impl true
  def start(_type, _args) do
    children = [
      ScrapingPipeline
    ]

    opts = [strategy: :one_for_one, name: Scraper.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
