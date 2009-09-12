# To change this template, choose Tools | Templates
# and open the template in the editor.

$:.unshift File.join(File.dirname(__FILE__),'..','lib')

require 'test/unit'
require 'node'

module PredictiveSearch
  class NodeTest < Test::Unit::TestCase
    def test_should_allow_addition_of_children
      node = Node.new.add(Node.new).add(Node.new);
      assert node.has_children
    end

    def test_should_create_a_child_called_london
      root = Node.new;
      assert root.has_no_children
      root.add(Node.new "London")
      assert_equal 1, root.number_of_children
    end

    def test_should_create_two_children
      root=Node.root
      root.add(Node.new "London").add(Node.new "London Bridge").add(Node.new "London Euston")
      assert_equal(1, root.number_of_children)
      assert_equal(2,root.get_child(Node.new "London").number_of_children)
    end

    def test_creation_of_root_node
      root = Node.root
      assert root.has_children
    end
  end
end
