defmodule BinTree do
  defstruct val: nil, left: %Empty{}, right: %Empty{}

  @type t :: %__MODULE__{}

  def insert(tree \\ %Empty{}, value)

  def insert(%Empty{}, value), do: %BinTree{:val => value}

  def insert(tree = %BinTree{:val => v, :left => l, :right => r}, value) do
    cond do
      v > value ->
        %BinTree{:val => v, :left => insert(l, value), :right => r}

      v < value ->
        %BinTree{:val => v, :left => l, :right => insert(r, value)}

      true ->
        tree
    end
  end
end
