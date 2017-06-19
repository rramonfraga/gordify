defmodule Gordify.HandlerMessages do

  # Regular expresions
  @hi ~r{(Hi|hi|hola|Hola)}
  @start ~r{(start|empieza|)}

  def handle_message(message, slack) do
    IO.puts inspect(message)
    cond do
      Regex.match?(@hi, message) -> "Hi! :yum:"
      Regex.match?(@start, message) -> "<!here> Who is in the brunch? (Make a reacions in this message)"
      true -> "I don't understand!"
    end
  end

  # Private Functions

  defp group_people(slack, timestamp) do
    # Slack.Web.Reactions.get(%{channel: slack.channel, timestamp: timestamp})
  end
end
