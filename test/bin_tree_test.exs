defmodule BinTreeTest do
  alias BinTree.{Node, Leaf}
  use ExUnit.Case
  doctest BinTree

  test "insert in empty tree" do
    assert BinTree.insert(%Leaf{}, 10) == %Node{
             :left => %Leaf{},
             :right => %Leaf{},
             :val => 10
           }
  end

  test "insert a smaller value than the root" do
    assert BinTree.insert(%Node{:left => %Leaf{}, :right => %Leaf{}, :val => 10}, 1) ==
             %Node{
               :left => %Node{:left => %Leaf{}, :right => %Leaf{}, :val => 1},
               :right => %Leaf{},
               :val => 10
             }
  end

  test "insert a bigger value than the root" do
    assert BinTree.insert(%Node{:left => %Leaf{}, :right => %Leaf{}, :val => 10}, 21) ==
             %Node{
               :right => %Node{:left => %Leaf{}, :right => %Leaf{}, :val => 21},
               :left => %Leaf{},
               :val => 10
             }
  end

  test "insert the same value won't alter the tree" do
    assert BinTree.insert(%Node{:left => %Leaf{}, :right => %Leaf{}, :val => 10}, 10) ==
             %Node{
               :left => %Leaf{},
               :right => %Leaf{},
               :val => 10
             }
  end

  test "insert nested value in right position" do
    complex_tree = %Node{
      :left => %Node{
        :left => %Leaf{},
        :right => %Node{:left => %Leaf{}, :right => %Leaf{}, :val => 8},
        :val => 6
      },
      :right => %Leaf{},
      :val => 10
    }

    assert BinTree.insert(complex_tree, 7) == %Node{
             :left => %Node{
               :left => %Leaf{},
               :right => %Node{
                 :left => %Node{:left => %Leaf{}, :right => %Leaf{}, :val => 7},
                 :right => %Leaf{},
                 :val => 8
               },
               :val => 6
             },
             :right => %Leaf{},
             :val => 10
           }
  end

  test "min value of empty tree is %Leaf{}" do
    assert BinTree.min(%Leaf{}) == nil
  end

  test "min value of one element tree is same element" do
    assert BinTree.min(%Node{:left => %Leaf{}, :right => %Leaf{}, :val => 10}) == 10
  end

  test "min value of complex tree is leftmost value" do
    complex_tree = %Node{
      :left => %Node{
        :left => %Leaf{},
        :right => %Node{:left => %Leaf{}, :right => %Leaf{}, :val => 8},
        :val => 6
      },
      :right => %Leaf{},
      :val => 10
    }

    assert BinTree.min(complex_tree) == 6
  end

  test "max value of empty tree is Empty" do
    assert BinTree.max(%Leaf{}) == nil
  end

  test "max value of one element tree is same element" do
    assert BinTree.max(%Node{:left => %Leaf{}, :right => %Leaf{}, :val => 10}) == 10
  end

  test "max value of complex tree is leftmost value" do
    complex_tree = %Node{
      :left => %Node{
        :right => %Node{
          :val => 8
        },
        :val => 6
      },
      :right => %Node{
        :right => %Node{
          :val => 22
        },
        :val => 11
      },
      :val => 10
    }

    assert BinTree.max(complex_tree) == 22
  end

  test "flatten tree will deliver an ordered array of values" do
    complex_tree = %Node{
      :left => %Node{
        :right => %Node{
          :val => 8
        },
        :val => 6
      },
      :right => %Node{
        :right => %Node{
          :val => 22
        },
        :val => 11
      },
      :val => 10
    }

    assert BinTree.flatten(complex_tree) == [6, 8, 10, 11, 22]
  end

  test "Flatten of a single node will result on a single value list" do
    complex_tree = %Node{
      :val => 8
    }

    assert BinTree.flatten(complex_tree) == [8]
  end

  test "Flatten of an %Leaf{} tree will return empty list" do
    assert BinTree.flatten(%Leaf{}) == []
  end
end
