defmodule AVLTree do
  defstruct val: nil, left: %Empty{}, right: %Empty{}

  def build(list \\ [])

  def build([]) do
    %Empty{}
  end

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

  def balanced?(tree \\ %Empty{})

  def balanced?(%Empty{}) do
    true
  end

  def balanced?(%AVLTree{:left => l, :right => r}) do
    cond do
      not balanced?(l) -> false
      not balanced?(r) -> false
      abs(height(l) - height(r)) > 1 -> false
      true -> true
    end
  end

  def height(tree \\ %Empty{})

  def height(%Empty{}) do
    0
  end

  def height(%AVLTree{:left => l, :right => r}) do
    1 + max(height(l), height(r))
  end

  def left(tree \\ %Empty{})

  def left(%Empty{}) do
    %Empty{}
  end

  def left(%AVLTree{:left => l}) do
    l
  end

  def right(tree \\ %Empty{})

  def right(%Empty{}) do
    %Empty{}
  end

  def right(%AVLTree{:right => l}) do
    l
  end

  def value(tree \\ %Empty{})

  def value(%Empty{}) do
    %Empty{}
  end

  def value(%AVLTree{:val => v}) do
    v
  end
end
