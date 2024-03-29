defmodule DashFloat.MixProject do
  use Mix.Project

  def project do
    [
      app: :dash_float,
      version: "0.0.0",
      elixir: "1.16.1",
      elixirc_paths: elixirc_paths(Mix.env()),
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      deps: deps(),
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [
        coveralls: :test,
        "coveralls.detail": :test,
        "coveralls.post": :test,
        "coveralls.html": :test,
        "coveralls.cobertura": :test
      ],
      dialyzer: [
        plt_add_apps: [
          :ex_unit
        ],
        plt_file: {:no_warn, "priv/plts/project.plt"},
        list_unused_filters: true
      ]
    ]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      mod: {DashFloat.Application, []},
      extra_applications: [:logger, :runtime_tools]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      {:bandit, "1.2.2"},
      {:credo, "1.7.4", only: [:dev, :test], runtime: false},
      {:dialyxir, "1.4.3", only: [:dev, :test], runtime: false},
      {:dns_cluster, "0.1.3"},
      {:ecto_sql, "3.11.1"},
      {:ex_machina, "2.7.0", only: :test},
      {:excoveralls, "0.18.0", only: :test},
      {:faker, "0.17.0", only: :test},
      {:finch, "0.18.0"},
      {:gettext, "0.24.0"},
      {:jason, "1.4.1"},
      {:phoenix, "1.7.11"},
      {:phoenix_ecto, "4.4.3"},
      {:postgrex, "0.17.4"},
      {:swoosh, "1.15.2"},
      {:telemetry_metrics, "0.6.2"},
      {:telemetry_poller, "1.0.0"}
    ]
  end

  # Aliases are shortcuts or tasks specific to the current project.
  # For example, to install project dependencies and perform other setup tasks, run:
  #
  #     $ mix setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    [
      setup: ["deps.get", "ecto.setup"],
      "ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
      "ecto.reset": ["ecto.drop", "ecto.setup"],
      test: ["ecto.create --quiet", "ecto.migrate --quiet", "test"],
      lint: ["format", "credo"],
      "lint.ci": ["format --check-formatted", "credo"]
    ]
  end
end
