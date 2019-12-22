defprotocol Tree do
  @doc "Common functions for Tree functions"

  @type tree() :: BinTree.tree() | BinTree.leaf()

  @spec min(tree()) :: integer() | nil
  def min(tree)

  @spec max(tree()) :: integer() | nil
  def max(tree)

  @spec flatten(tree()) :: [integer()]
  def flatten(tree)
end

defimpl Tree, for: Empty do
  def min(%Empty{}) do
    nil
  end

  def max(%Empty{}) do
    nil
  end

  def flatten(%Empty{}) do
    []
  end
end

defimpl Tree, for: BinTree do
  def min(%Empty{}), do: nil

  def min(%BinTree{:val => val, :left => l}) do
    case l do
      %Empty{} -> val
      _ -> min(l)
    end
  end

  def max(%Empty{}), do: nil

  def max(%BinTree{:val => val, :right => r}) do
    case r do
      %Empty{} -> val
      _ -> max(r)
    end
  end

  def flatten(%Empty{}), do: []

  def flatten(%BinTree{:left => l, :right => r, :val => v}) do
    flatten(l) ++ [v] ++ flatten(r)
  end
end

defimpl Tree, for: AVLTree do
  def min(%Empty{}), do: nil

  def min(tree) do
    case tree do
      %BinTree{:left => %Empty{}} -> tree.val
      %BinTree{:left => left_tree} -> min(left_tree)
    end
  end

  def max(%Empty{}), do: nil

  def max(tree) do
    case tree do
      %BinTree{:right => %Empty{}} -> tree.val
      %BinTree{:right => r} -> max(r)
    end
  end

  def flatten(%Empty{}), do: []

  def flatten(%BinTree{:left => l, :right => r, :val => v}) do
    flatten(l) ++ [v] ++ flatten(r)
  end
end
