alias BinTree.{Leaf, Node}

defprotocol Tree do
  @doc "Common functions for Tree functions"

  @type tree() :: BinTree.tree()

  @spec min(tree()) :: integer() | nil
  def min(tree)

  @spec max(tree()) :: integer() | nil
  def max(tree)

  @spec flatten(tree()) :: [integer()]
  def flatten(tree)
end
# 
# defimpl Tree, for: Leaf do
#   def min(%Leaf{}), do: nil
#
#   def max(%Leaf{}), do: nil
#
#   def flatten(%Leaf{}), do: []
# end
#
# defimpl Tree, for: Node do
#   def min(%Leaf{}), do: nil
#
#   def min(tree) do
#     case tree do
#       %Node{:left => %Leaf{}} -> tree.val
#       %Node{:left => left_tree} -> min(left_tree)
#     end
#   end
#
#   def max(%Leaf{}), do: nil
#
#   def max(tree) do
#     case tree do
#       %Node{:right => %Leaf{}} -> tree.val
#       %Node{:right => r} -> max(r)
#     end
#   end
#
#   def flatten(%Leaf{}), do: []
#
#   def flatten(%Node{:left => l, :right => r, :val => v}) do
#     flatten(l) ++ [v] ++ flatten(r)
#   end
# end
