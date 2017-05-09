defmodule Gordify.Slack do
  use Slack

  @url_reactions "https://slack.com/api/reactions.get"

  def handle_connect(slack, state) do
    IO.puts "Connected as #{slack.me.name}"
    {:ok, state}
  end

  def handle_event(message = %{type: "message"}, slack, state) do
    Regex.run(~r/<@#{slack.me.id}>\s*(.*)/, message.text)
    |> gordify_message(message.channel, message.user, slack)
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

  defp gordify_message(msg, channel, user, slack) when msg != nil do
    msg
    |> Enum.at(1)
    |> Gordify.HandlerMessages.handle_message(slack)
    |> send_message(channel, slack)
  end
  defp gordify_message(msg, _, _, _) when msg == nil do end

  defp get_user_from_reactions do
     Tesla.get(@url_reactions)
  end
end
