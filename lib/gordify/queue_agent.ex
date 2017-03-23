defmodule Gordify.QueueAgent do
  def start_link(queue, name) do
    Agent.start_link(fn -> queue end, name: name)
  end

  def add(queue, item) do
    Agent.cast(queue, fn(state) -> state ++ [item] end)
  end

  def get(queue) do
    Agent.get_and_update(queue, fn([item | state]) -> {item, state} end)
  end

  def shuffle(queue) do
    Agent.update(queue, fn(state) -> Enum.shuffle(state) end)
  end
end
