defmodule ScrapingPipeline do
  use Broadway
  require Logger

  def start_link(_args) do
    options = [
      name: ScrapingPipeline,
      producer: [
        module: {PageProducer, []},
        transformer: {ScrapingPipeline, :transform, []}
      ],
      processors: [
        default: [max_demand: 1, concurrency: 2]
      ],
      batchers: [
        default: [max_demand: 1, concurrency: 2]
      ]
    ]

    Broadway.start_link(__MODULE__, options)
  end

  @impl true
  def handle_message(_processor, message, _context) do
    if Scraper.online?(message.data) do
      Broadway.Message.put_batch_key(message, message.data)
    else
      Broadway.Message.failed(message, "offline")
    end
  end

  @impl true
  def handle_batch(_batcher, [message], _batch_info, _context) do
    Logger.info("Batch Processor received #{message.data}")
    Scraper.work()

    [message]
  end

  def transform(event, _opts) do
    %Broadway.Message{
      data: event,
      acknowledger: {ScrapingPipeline, :pages, []}
    }
  end

  def ack(:pages, _successful, _failed) do
    :ok
  end

  #
end
