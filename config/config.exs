# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :backend_api,
  ecto_repos: [BackendApi.Repo]

# Configures the endpoint
config :backend_api, BackendApiWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [
    formats: [json: BackendApiWeb.ErrorJSON],
    layout: false
  ],
  pubsub_server: BackendApi.PubSub,
  live_view: [signing_salt: "uAbqbMrc"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

  config :backend_api, BackendApiWeb.Auth.Guardian,
  issuer: "backend_api",
  secret_key: "QuXTrGQHYSD0ZMkdbzBO8fY9W53q8UUL0C1AMtc4gTXrOjF5eR9rmSYDO+K3l7J+"

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
