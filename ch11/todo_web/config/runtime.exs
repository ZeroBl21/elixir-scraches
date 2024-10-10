import Config

http_port =
  if config_env() != :test,
    do: System.get_env("EX_TODO_HTTP_PORT", "5173"),
    else: System.get_env("EX_TODO_TEST_HTTP_PORT", "5174")

config :todo, http_port: String.to_integer(http_port)
