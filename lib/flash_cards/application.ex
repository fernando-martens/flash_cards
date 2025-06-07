defmodule FlashCards.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      FlashCardsWeb.Telemetry,
      FlashCards.Repo,
      {DNSCluster, query: Application.get_env(:flash_cards, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: FlashCards.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: FlashCards.Finch},
      # Start a worker by calling: FlashCards.Worker.start_link(arg)
      # {FlashCards.Worker, arg},
      # Start to serve requests, typically the last entry
      FlashCardsWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: FlashCards.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    FlashCardsWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
