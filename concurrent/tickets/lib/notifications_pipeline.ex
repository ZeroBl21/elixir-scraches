defmodule NotificationsPipeline do
  use Broadway

  @producer BroadwayRabbitMQ.Producer
  @producer_config [
    queue: "notifications_queue",
    declare: [durable: true],
    on_failure: :reject_and_requeue,
    qos: [prefetch_count: 100]
  ]

  def start_link(_args) do
    options = [
      name: NotificationsPipeline,
      producer: [module: {@producer, @producer_config}],
      processors: [
        default: []
      ],
      processors: [
        email: [concurrency: 5, batch_timeout: 10_000]
      ]
    ]

    Broadway.start_link(__MODULE__, options)
  end

  def handle_message(_processor, message, _context) do
    message
    |> Broadway.Message.put_batcher(:email)
    |> Broadway.Message.put_batch_key(message.data.recipent)
  end

  def prepare_messages(messages, _context) do
    Enum.map(messages, fn msg ->
      Broadway.Message.update_data(msg, fn data ->
        [type, recipent] = String.split(data, ",")
        %{type: type, recipent: recipent}
      end)
    end)
  end

  def handle_batch(_batcher, messages, batch_info, _context) do
    IO.puts("#{inspect(self())} Batch #{batch_info.batcher}
      #{batch_info.batch_key}")

    # TODO: Send email to the user with all the information

    messages
  end

  #
end
