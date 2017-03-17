defmodule Gordify.Slack do
  use Slack

  def handle_connect(slack, state) do
    IO.puts "Connected as #{slack.me.name}"
    {:ok, state}
  end

  def handle_event(message = %{type: "message"}, slack, state) do
    Regex.run(~r/<@#{slack.me.id}>\s*(.*)/, message.text)
    |> gordify_message(message.channel, slack)
    {:ok, state}
  end
  def handle_event(_, _, state), do: {:ok, state}

  def handle_info({:message, text, channel}, slack, state) do
    IO.puts "Sending your message, captain!"

    send_message(text, channel, slack)

    {:ok, state}
  end
  def handle_info(_, _, state), do: {:ok, state}

  # Private funtions

  defp gordify_message(msg, channel, slack) when msg != nil do
    msg
    |> Enum.at(1)
    |> Gordify.HandlerMessages.handle_message
    |> send_message(channel, slack)
  end
  defp gordify_message(msg, _, _) when msg == nil do end
end
