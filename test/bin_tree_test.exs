defmodule BinTreeTest do
  use ExUnit.Case
  doctest BinTree

  test "insert in empty tree" do
    assert BinTree.insert(%Empty{}, 10) == %BinTree{
             :left => %Empty{},
             :right => %Empty{},
             :val => 10
           }
  end

  test "insert a smaller value than the root" do
    assert BinTree.insert(%BinTree{:left => %Empty{}, :right => %Empty{}, :val => 10}, 1) ==
             %BinTree{
               :left => %BinTree{:left => %Empty{}, :right => %Empty{}, :val => 1},
               :right => %Empty{},
               :val => 10
             }
  end

  test "insert a bigger value than the root" do
    assert BinTree.insert(%BinTree{:left => %Empty{}, :right => %Empty{}, :val => 10}, 21) ==
             %BinTree{
               :right => %BinTree{:left => %Empty{}, :right => %Empty{}, :val => 21},
               :left => %Empty{},
               :val => 10
             }
  end

  test "insert the same value won't alter the tree" do
    assert BinTree.insert(%BinTree{:left => %Empty{}, :right => %Empty{}, :val => 10}, 10) ==
             %BinTree{
               :left => %Empty{},
               :right => %Empty{},
               :val => 10
             }
  end

  test "insert nested value in right position" do
    complex_tree = %BinTree{
      :left => %BinTree{
        :left => %Empty{},
        :right => %BinTree{:left => %Empty{}, :right => %Empty{}, :val => 8},
        :val => 6
      },
      :right => %Empty{},
      :val => 10
    }

    assert BinTree.insert(complex_tree, 7) == %BinTree{
             :left => %BinTree{
               :left => %Empty{},
               :right => %BinTree{
                 :left => %BinTree{:left => %Empty{}, :right => %Empty{}, :val => 7},
                 :right => %Empty{},
                 :val => 8
               },
               :val => 6
             },
             :right => %Empty{},
             :val => 10
           }
  end

  test "min value of empty tree is %Empty{}" do
    assert Tree.min(%Empty{}) == nil
  end

  test "min value of one element tree is same element" do
    assert Tree.min(%BinTree{:left => %Empty{}, :right => %Empty{}, :val => 10}) == 10
  end

  test "min value of complex tree is leftmost value" do
    complex_tree = %BinTree{
      :left => %BinTree{
        :left => %Empty{},
        :right => %BinTree{:left => %Empty{}, :right => %Empty{}, :val => 8},
        :val => 6
      },
      :right => %Empty{},
      :val => 10
    }

    assert Tree.min(complex_tree) == 6
  end

  test "max value of empty tree is Empty" do
    assert Tree.max(%Empty{}) == nil
  end

  test "max value of one element tree is same element" do
    assert Tree.max(%BinTree{:left => %Empty{}, :right => %Empty{}, :val => 10}) == 10
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

  test "Flatten of an %Empty{} tree will return empty list" do
    assert Tree.flatten(%Empty{}) == []
  end
end
