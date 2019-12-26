defmodule AVLTreeTest do
  use ExUnit.Case

  alias BinTree.{AVLTree, Leaf, Node}

  doctest BinTree.AVLTree

  test "tree height of an empty tree is 0" do
    assert AVLTree.height(%Leaf{}) == 0
  end

  test "tree height should be the size of longest branch" do
    tree = %Node{
      :right => %Node{
        :right => %Node{:val => 4},
        :val => 2
      },
      :left => %Leaf{},
      :val => 1
    }

    assert AVLTree.height(tree) == 3
  end

  test "empty tree is balanced" do
    assert AVLTree.balanced?(%Leaf{}) == true
  end

  test "balanced tree should return true" do
    balanced_tree = %Node{
      :left => %Node{:val => 1},
      :right => %Node{:val => 3},
      :val => 2
    }

    assert AVLTree.balanced?(balanced_tree) == true
  end

  test "insert in empty tree" do
    assert AVLTree.insert(%Leaf{}, 10) == %Node{:val => 10}
  end

  test "insert a smaller value than the root" do
    assert AVLTree.insert(%Node{:val => 10}, 1) == %Node{
             :left => %Node{:val => 1},
             :val => 10
           }
  end

  test "inserting a value that unbalances a tree should return a balanced tree" do
    to_be_unbalanced_tree = %Node{
      :right => %Node{:val => 2},
      :val => 1
    }

    balanced_after_insert = %Node{
      :left => %Node{:val => 1},
      :right => %Node{:val => 3},
      :val => 2
    }

    assert AVLTree.insert(to_be_unbalanced_tree, 3) == balanced_after_insert
    assert true == AVLTree.balanced?(balanced_after_insert)
  end

  test "inserting value should trigger a SR2 rotation and return a balanced tree" do
    #   (2)              (2)                      (4)
    #   / \              / \      (SR 2)          / \
    # (1) (4)          (1) (4)    _____         (2) (5)
    #     / \              / \                  / \   \
    #   (3)  (5)         (3)  (5)             (1) (3)  (6)
    #                          \
    #                          (6)

    to_be_unbalanced_tree = %Node{
      :left => %Node{:val => 1},
      :right => %Node{:left => %Node{:val => 3}, :right => %Node{:val => 5}, :val => 4},
      :val => 2
    }

    balanced_tree = %Node{
      :left => %Node{:val => 2, :left => %Node{:val => 1}, :right => %Node{:val => 3}},
      :right => %Node{:right => %Node{:val => 6}, :val => 5},
      :val => 4
    }

    assert AVLTree.insert(to_be_unbalanced_tree, 6) == balanced_tree
  end

  test "should create a balanced tree based on a list" do
    balanced_tree = %Node{
      :left => %Node{:val => 2, :left => %Node{:val => 1}, :right => %Node{:val => 3}},
      :right => %Node{:right => %Node{:val => 6}, :val => 5},
      :val => 4
    }

    assert AVLTree.build([2, 1, 1, 3, 4, 5, 6]) == balanced_tree
  end
end
