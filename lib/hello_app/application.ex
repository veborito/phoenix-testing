defmodule HelloApp.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      HelloAppWeb.Telemetry,
      HelloApp.Repo,
      {DNSCluster, query: Application.get_env(:hello_app, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: HelloApp.PubSub},
      # Start a worker by calling: HelloApp.Worker.start_link(arg)
      # {HelloApp.Worker, arg},
      # Start to serve requests, typically the last entry
      HelloAppWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: HelloApp.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    HelloAppWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
