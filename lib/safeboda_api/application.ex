defmodule SafebodaApi.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    unless Mix.env() == :prod do
      Envy.auto_load()
    end

    # List all child processes to be supervised
    children = [
      # Starts a worker by calling: SafebodaApi.Worker.start_link(arg)
      # {SafebodaApi.Worker, arg}
      SafebodaApi.Cache,
      SafebodaApi.Repo,
      SafebodaApi.Maru
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: SafebodaApi.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
