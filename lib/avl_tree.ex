defmodule AVLTree do
  defstruct val: nil, left: %Empty{}, right: %Empty{}

  @type t :: %__MODULE__{}

  def build([]), do: %Empty{}

  def build(list) do
    List.foldl(list, %Empty{}, fn item, tree -> insert(tree, item) end)
  end

  def insert(tree \\ %Empty{}, value)

  def insert(%Empty{}, value) do
    %AVLTree{:val => value}
  end

  def insert(tree = %AVLTree{:val => node_value}, value) do
    cond do
      node_value > value ->
        %AVLTree{
          :val => tree.val,
          :left => insert(tree.left, value),
          :right => tree.right
        }
        |> rotate

      node_value < value ->
        %AVLTree{
          :val => tree.val,
          :left => tree.left,
          :right => insert(tree.right, value)
        }
        |> rotate

      true ->
        tree
    end
  end

  def rotate(tree \\ %Empty{})

  def rotate(%Empty{}) do
    %Empty{}
  end

  def rotate(tree = %AVLTree{:val => v, :left => l, :right => r}) do
    cond do
      not balanced?(l) ->
        %AVLTree{
          :val => v,
          :left => rotate(l),
          :right => r
        }

      not balanced?(r) ->
        %AVLTree{
          :val => v,
          :left => l,
          :right => rotate(r)
        }

      # SR RR
      height(l) + 1 < height(r) && height(left(r)) < height(right(r)) ->
        %AVLTree{
          :val => value(r),
          :left => %AVLTree{
            :val => v,
            :left => l,
            :right => left(r)
          },
          :right => right(r)
        }

      # SR LL
      height(r) + 1 < height(l) && height(right(l)) < height(left(l)) ->
        %AVLTree{
          :val => value(l),
          :left => left(l),
          :right => %AVLTree{
            :val => v,
            :left => right(l),
            :right => r
          }
        }

      # DR RL
      height(l) + 1 < height(r) && height(left(r)) > height(right(r)) ->
        %AVLTree{
          :val => value(left(r)),
          :left => %AVLTree{
            :val => v,
            :left => l,
            :right => left(left(r))
          },
          :right => %AVLTree{
            :val => value(r),
            :left => right(left(r)),
            :right => right(r)
          }
        }

      # DR LR
      height(r) + 1 < height(l) && height(right(l)) > height(left(l)) ->
        %AVLTree{
          :val => value(right(l)),
          :left => %AVLTree{
            :val => value(l),
            :left => left(l),
            :right => left(right(l))
          },
          :right => %AVLTree{
            :val => v,
            :left => right(right(l)),
            :right => r
          }
        }

      true ->
        tree
    end
  end

  def balanced?(%Empty{}), do: true

  def balanced?(%AVLTree{:left => l, :right => r}) do
    cond do
      not balanced?(l) -> false
      not balanced?(r) -> false
      abs(height(l) - height(r)) > 1 -> false
      true -> true
    end
  end

  def height(%Empty{}), do: 0

  def height(%AVLTree{:left => l, :right => r}) do
    1 + max(height(l), height(r))
  end

  def left(%Empty{}), do: %Empty{}
  def left(%AVLTree{:left => l}), do: l

  def right(%Empty{}), do: %Empty{}
  def right(%AVLTree{:right => r}), do: r

  def value(%Empty{}), do: %Empty{}
  def value(%AVLTree{:val => v}), do: v
end
