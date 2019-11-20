defmodule SafebodaApi.MixProject do
  use Mix.Project

  def project do
    [
      app: :safeboda_api,
      version: "0.1.0",
      elixir: "~> 1.9",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger, :maru, :httpotion],
      mod: {SafebodaApi.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
      {:confex, "~> 3.4.0"},
      {:envy, "~> 1.1.1"},
      {:ecto_sql, "~> 3.0"},
      {:ecto_soft_delete, "~> 1.0"},
      {:money, "~> 1.4"},
      {:postgrex, ">= 0.0.0"},
      {:nebulex_ecto, "~> 0.1"},
      {:espec, "~> 1.7.0", only: :test},
      {:maru, "~> 0.13"},
      {:plug_cowboy, "~> 2.0"},
      {:jason, "~> 1.1"},
      {:httpotion, "~> 3.1.0"},
      {:distance, "~> 0.2.1"}
    ]
  end
end
