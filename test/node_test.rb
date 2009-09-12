$:.unshift File.join(File.dirname(__FILE__),'..','lib')

require 'test/unit'
require 'node'

module RadixTree
  class NodeTest < Test::Unit::TestCase

    def test_two_nodes_should_be_equatable
      assert(Node.new("London") == Node.new("London"), "London and London should be equal")
      assert(Node.new("London") != Node.new("Manchester"), "London and Manchester are two different places. They can't be equal")
    end

    def test_add_a_new_child
      london = Node.new "London"
      london.add Node.new "London Bridge"
      london.add Node.new "London Cannon Street"
      assert(2, london.number_of_children)
    end

    def test_should_not_add_a_wrong_child
      london = Node.new "London"
      assert !london.add(Node.new "Manchester")
      assert london.has_no_children?
    end

    def test_should_produce_readable_representation_of_itself
      london = Node.new "London"
      assert("London" == london.to_s)
    end

    def test_should_split_and_fork_children_when_siblings_are_detected
      london = Node.new "London"
      assert london.has_no_children?

      london.add Node.new "London Bridge"
      assert_equal 1, london.number_of_children
      
      london.add Node.new "London Cannon Street"
      assert_equal 2, london.number_of_children

      london.add Node.new "London Field"
      assert_equal 3, london.number_of_children

      london.add Node.new "London Blackfairs"
      assert_equal 3, london.number_of_children, "London should have forked a London B child with two of its own children London Bridge and London Blackfairs"
    end
  end
end