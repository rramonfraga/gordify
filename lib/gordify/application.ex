defmodule Gordify.Application do
  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    slack_token = Application.get_env(:gordify, Gordify.Slack)[:token]

    # Define workers and child supervisors to be supervised
    children = [
      # Starts a worker by calling: Gordify.Worker.start_link(arg1, arg2, arg3)
      worker(Slack.Bot, [Gordify.Slack, [], slack_token]),
    ]

    # See http://elixir-lang.org/docs/stable/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Gordify.Supervisor]
    Supervisor.start_link(children, opts)
    Gordify.QueueAgent.start_link([], :people)
  end
end
