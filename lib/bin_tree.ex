defmodule BinTree do
  import Algae

  alias BinTree.{Leaf, Node}

  defsum do
    defdata(Leaf :: none())

    defdata Node do
      val :: integer()
      left :: BinTree.t() \\ BinTree.Leaf.new()
      right :: BinTree.t() \\ BinTree.Leaf.new()
    end
  end

  def min(%Leaf{}), do: nil

  def min(tree) do
    case tree do
      %Node{:left => %Leaf{}} -> tree.val
      %Node{:left => left_tree} -> min(left_tree)
    end
  end

  def max(%Leaf{}), do: nil

  def max(tree) do
    case tree do
      %Node{:right => %Leaf{}} -> tree.val
      %Node{:right => r} -> max(r)
    end
  end

  def flatten(%Leaf{}), do: []

  def flatten(%Node{:left => l, :right => r, :val => v}) do
    flatten(l) ++ [v] ++ flatten(r)
  end
  
  @spec new() :: Leaf.t()
  def new(), do: %Leaf{}

  def insert(%Leaf{}, value), do: %Node{:val => value}

  def insert(tree = %Node{:val => v, :left => l, :right => r}, value) do
    cond do
      v > value ->
        %Node{:val => v, :left => insert(l, value), :right => r}

      v < value ->
        %Node{:val => v, :left => l, :right => insert(r, value)}

      true ->
        tree
    end
  end

  defmodule AVLTree do

    def build([]), do: %Leaf{}

    def build(list) do
      List.foldl(list, %Leaf{}, fn item, tree -> insert(tree, item) end)
    end

    def insert(%Leaf{}, value) do
      %Node{:val => value}
    end

    def insert(tree = %Node{:val => node_value}, value) do
      cond do
        node_value > value ->
          %Node{
            :val => tree.val,
            :left => insert(tree.left, value),
            :right => tree.right
          }
          |> rotate

        node_value < value ->
          %Node{
            :val => tree.val,
            :left => tree.left,
            :right => insert(tree.right, value)
          }
          |> rotate

        true ->
          tree
      end
    end

    def rotate(%Leaf{}), do: %Leaf{}

    def rotate(tree = %Node{:val => v, :left => l, :right => r}) do
      cond do
        not balanced?(l) ->
          %Node{
            :val => v,
            :left => rotate(l),
            :right => r
          }

        not balanced?(r) ->
          %Node{
            :val => v,
            :left => l,
            :right => rotate(r)
          }

        # SR RR
        height(l) + 1 < height(r) && height(left(r)) < height(right(r)) ->
          %Node{
            :val => value(r),
            :left => %Node{
              :val => v,
              :left => l,
              :right => left(r)
            },
            :right => right(r)
          }

        # SR LL
        height(r) + 1 < height(l) && height(right(l)) < height(left(l)) ->
          %Node{
            :val => value(l),
            :left => left(l),
            :right => %Node{
              :val => v,
              :left => right(l),
              :right => r
            }
          }

        # DR RL
        height(l) + 1 < height(r) && height(left(r)) > height(right(r)) ->
          %Node{
            :val => value(left(r)),
            :left => %Node{
              :val => v,
              :left => l,
              :right => left(left(r))
            },
            :right => %Node{
              :val => value(r),
              :left => right(left(r)),
              :right => right(r)
            }
          }

        # DR LR
        height(r) + 1 < height(l) && height(right(l)) > height(left(l)) ->
          %Node{
            :val => value(right(l)),
            :left => %Node{
              :val => value(l),
              :left => left(l),
              :right => left(right(l))
            },
            :right => %Node{
              :val => v,
              :left => right(right(l)),
              :right => r
            }
          }

        true ->
          tree
      end
    end

    def balanced?(%Leaf{}), do: true

    def balanced?(%Node{:left => l, :right => r}) do
      cond do
        not balanced?(l) -> false
        not balanced?(r) -> false
        abs(height(l) - height(r)) > 1 -> false
        true -> true
      end
    end

    def height(%Leaf{}), do: 0

    def height(%Node{:left => l, :right => r}) do
      1 + max(height(l), height(r))
    end

    def left(%Leaf{}), do: %Leaf{}
    def left(%Node{:left => l}), do: l

    def right(%Leaf{}), do: %Leaf{}
    def right(%Node{:right => r}), do: r

    def value(%Leaf{}), do: %Leaf{}
    def value(%Node{:val => v}), do: v
  end
end
