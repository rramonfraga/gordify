defmodule Gordify.HandlerMessages do

  @hi ~r{(Hi|hi|hola|Hola)}

  def handle_message(message) do
    IO.puts inspect(message)
    cond do
      Regex.match?(@hi, message) -> "Hi! :yum:"
      true -> "I don't understand!"
    end
  end
end
