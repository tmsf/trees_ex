defmodule AVLTreeTest do
  use ExUnit.Case
  alias BinTree.AVLTree, as: AVLTree
  
  doctest BinTree.AVLTree

  test "tree height of an empty tree is 0" do
    assert AVLTree.height(%Empty{}) == 0
  end

  test "tree height should be the size of longest branch" do
    tree = %BinTree{
      :right => %BinTree{
        :right => %BinTree{:val => 4},
        :val => 2
      },
      :val => 1
    }

    assert AVLTree.height(tree) == 3
  end

  test "empty tree is balanced" do
    assert AVLTree.balanced?(%Empty{}) == true
  end

  test "balanced tree should return true" do
    balanced_tree = %BinTree{
      :left => %BinTree{:val => 1},
      :right => %BinTree{:val => 3},
      :val => 2
    }

    assert AVLTree.balanced?(balanced_tree) == true
  end

  test "insert in empty tree" do
    assert AVLTree.insert(%Empty{}, 10) == %BinTree{:val => 10}
  end

  test "insert a smaller value than the root" do
    assert AVLTree.insert(%BinTree{:val => 10}, 1) == %BinTree{
             :left => %BinTree{:val => 1},
             :val => 10
           }
  end

  test "inserting a value that unbalances a tree should return a balanced tree" do
    to_be_unbalanced_tree = %BinTree{
      :right => %BinTree{:val => 2},
      :val => 1
    }

    balanced_after_insert = %BinTree{
      :left => %BinTree{:val => 1},
      :right => %BinTree{:val => 3},
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

    to_be_unbalanced_tree = %BinTree{
      :left => %BinTree{:val => 1},
      :right => %BinTree{:left => %BinTree{:val => 3}, :right => %BinTree{:val => 5}, :val => 4},
      :val => 2
    }

    balanced_tree = %BinTree{
      :left => %BinTree{:val => 2, :left => %BinTree{:val => 1}, :right => %BinTree{:val => 3}},
      :right => %BinTree{:right => %BinTree{:val => 6}, :val => 5},
      :val => 4
    }

    assert AVLTree.insert(to_be_unbalanced_tree, 6) == balanced_tree
  end

  test "should create a balanced tree based on a list" do
    balanced_tree = %BinTree{
      :left => %BinTree{:val => 2, :left => %BinTree{:val => 1}, :right => %BinTree{:val => 3}},
      :right => %BinTree{:right => %BinTree{:val => 6}, :val => 5},
      :val => 4
    }

    assert AVLTree.build([2, 1, 1, 3, 4, 5, 6]) == balanced_tree
  end

  test "min value of empty tree is nil" do
    assert Tree.min(%Empty{}) == nil
  end

  test "min value of one element tree is same element" do
    assert Tree.min(%BinTree{:val => 10}) == 10
  end

  test "min value of complex tree is leftmost value" do
    complex_tree = %BinTree{
      :left => %BinTree{
        :right => %BinTree{:val => 8},
        :val => 6
      },
      :val => 10
    }

    assert Tree.min(complex_tree) == 6
  end

  test "max value of empty tree is nil" do
    assert Tree.max(%Empty{}) == nil
  end

  test "max value of one element tree is same element" do
    assert Tree.max(%BinTree{:val => 10}) == 10
  end

  test "max value of complex tree is leftmost value" do
    complex_tree = %BinTree{
      :left => %BinTree{
        :right => %BinTree{
          :val => 8
        },
        :val => 6
      },
      :right => %BinTree{
        :right => %BinTree{
          :val => 22
        },
        :val => 11
      },
      :val => 10
    }

    assert Tree.max(complex_tree) == 22
  end

  test "flatten tree will deliver an ordered array of values" do
    complex_tree = %BinTree{
      :left => %BinTree{
        :right => %BinTree{
          :val => 8
        },
        :val => 6
      },
      :right => %BinTree{
        :right => %BinTree{
          :val => 22
        },
        :val => 11
      },
      :val => 10
    }

    assert Tree.flatten(complex_tree) == [6, 8, 10, 11, 22]
  end

  test "Flatten of a single node will result on a single value list" do
    complex_tree = %BinTree{
      :val => 8
    }

    assert Tree.flatten(complex_tree) == [8]
  end

  test "Flatten of a nullable tree will return empty list" do
    assert Tree.flatten(%Empty{}) == []
  end
end
