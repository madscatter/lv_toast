# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

# Configures the endpoint
config :lv_toast, LvToastWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "HDizqfj+wikOlplTeEqcJVVdm45npV+BnTAfrD89USBng5oToaiXr/AeK9rHSM9V",
  render_errors: [view: LvToastWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: LvToast.PubSub, adapter: Phoenix.PubSub.PG2],
  live_view: [
    signing_salt: "S7A5ZVl2rUt1xGZRgREUssD5+W5ESS1y"
  ]
# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
