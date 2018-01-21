use Mix.Config

config :config_example,
  message_one: "This is a shared message!"

import_config "#{Mix.env}.exs"
