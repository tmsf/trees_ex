defprotocol Tree do
  @doc "Common functions for Tree functions"
  @type tree() :: String.t()

  # def insert(tree) 

  @spec min(tree()) :: integer()
  def min(tree)

  @spec max(tree()) :: integer()
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
  def min(tree \\ %Empty{})

  def min(tree) do
    case tree do
      %BinTree{:left => %Empty{}} -> tree.val
      %BinTree{:left => left_tree} -> min(left_tree)
    end
  end

  def max(tree \\ %Empty{})

  def max(tree) do
    case tree do
      %BinTree{:right => %Empty{}} -> tree.val
      %BinTree{:right => right_tree} -> max(right_tree)
    end
  end

  def flatten(tree \\ %Empty{})
  def flatten(%Empty{}), do: []

  def flatten(%BinTree{:left => l, :right => r, :val => v}) do
    flatten(l) ++ [v] ++ flatten(r)
  end
end

defimpl Tree, for: AVLTree do
  def min(tree \\ %Empty{})

  def min(%Empty{}) do
    nil
  end

  def min(tree) do
    case tree do
      %AVLTree{:left => %Empty{}} -> tree.val
      %AVLTree{:left => left_tree} -> min(left_tree)
    end
  end

  def max(tree \\ %Empty{})

  def max(%Empty{}) do
    nil
  end

  def max(tree) do
    case tree do
      %AVLTree{:right => %Empty{}} -> tree.val
      %AVLTree{:right => r} -> max(r)
    end
  end

  def flatten(tree \\ %Empty{})

  def flatten(%Empty{}) do
    []
  end

  def flatten(%AVLTree{:left => l, :right => r, :val => v}) do
    flatten(l) ++ [v] ++ flatten(r)
  end
end
