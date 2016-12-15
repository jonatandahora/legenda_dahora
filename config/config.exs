# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :legenda_dahora,
  ecto_repos: [LegendaDahora.Repo]

# Configures the endpoint
config :legenda_dahora, LegendaDahora.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "1fOI3vpP+ZOozh8CPxJePXdS2TcMFCb50KEuXwM+T+iIoWIUKmHIXUfJ/r0jZ75t",
  render_errors: [view: LegendaDahora.ErrorView, accepts: ~w(html json)],
  pubsub: [name: LegendaDahora.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
