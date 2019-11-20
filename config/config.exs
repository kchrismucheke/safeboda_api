use Mix.Config

config :safeboda_api, ecto_repos: [SafebodaApi.Repo]

config :safeboda_api, SafebodaApi.Repo,
  database: "safeboda_api_repo",
  username: "chris",
  password: "sysadmin",
  hostname: "localhost",
  show_sensitive_data_on_connection_error: true


config :postgrex, :json_library, Jason
config :safeboda_api, :json_library, Jason

config :safeboda_api, SafebodaApi.Maru,
  adapter: Plug.Adapters.Cowboy,
  plug: SafebodaApi.API,
  scheme: :http,
  ip: {0, 0, 0, 0},
  bind_addr: "0.0.0.0",
  port: {:system, "PORT"}

config :safeboda_api, maru_servers: [SafebodaApi.Maru]

config :money,
  default_currency: :KES

config :safeboda_api, SafebodaApi.Cache,
  n_shards: 2,
  gc_interval: 600

config :logger, handle_sasl_reports: true

config :logger, level: :debug
