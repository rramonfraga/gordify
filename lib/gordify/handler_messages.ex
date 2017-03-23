defmodule Gordify.HandlerMessages do

  # Regular expresions
  @hi ~r{(Hi|hi|hola|Hola)}
  @add ~r{(I\'m in|i\'m in|I am in|i am in)}


  def handle_message(message, user) do
    IO.puts inspect(message)
    cond do
      Regex.match?(@hi, message) -> "Hi! :yum:"
      Regex.match?(@add, message) -> add_person(user)
      true -> "I don't understand!"
    end
  end


  defp add_person(user) do
    Gordify.QueueAgent.add(:people, user)
    "Yum yum! <@#{user}> is in the brunch!"
  end

end
