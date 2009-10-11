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
      begin
        assert !london.add(Node.new "Manchester")
        fail "#{london} should not have allowed Manchester to be added as a child"
      rescue NotMyChildError
      ensure
        assert london.has_no_children?
      end     
      
    end

    def test_should_produce_readable_representation_of_itself
      london = Node.new "London"
      assert("London" == london.to_s)
    end

#    def test_should_produce_readable_representation_of_tree
#      london = Node.new "London"
#
#      london_bridge = Node.new "London Bridge"
#      london_bridge.add Node.new "London Bridge Falling"
#
#      puts london_bridge.tree_string
#
#      london.add london_bridge
#      london.add Node.new "London Cannon Street"
#
#      puts london.tree_string
#
#      assert "London\t\n|\n|__London Bridge\n|\n|__London Cannon Street" == london.tree_string
#    end

    def test_should_identify_already_added_child

      london = Node.new "London"
      london.add Node.new "London Bridge"

      assert london.has_child Node.new 'London Bridge'
    end


    def test_should_automatically_fork_child
      london = Node.new "London"

      london.add Node.new "London Bridge"
      london.add Node.new "London Blackfairs"

      assert london.has_child Node.new "London B"
    end

    def test_should_be_unequal_if_other_is_nil
      assert Node.new "London" != nil
    end

    def test_should_return_child
      london = Node.new "London"
      london.add Node.new "London Bridge"

      london_bridge = london.find_child Node.new "London Bridge"
      puts london_bridge

      assert london_bridge != nil
    end

    def test_auto_forked_child_should_contain_children_that_previously_existed_at_its_place
      london = Node.new "London"
      london.add Node.new "London Bridge"
      london.add Node.new "London Blackfairs"

      london_b = london.find_child Node.new "London B"
      
      assert_equal 2, london_b.number_of_children
      assert london_b.find_child(Node.new 'London Bridge') != nil
      assert london_b.find_child(Node.new 'London Blackfairs') != nil
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

    def test_should_add_grand_child

      london = Node.new "London"
      london_b = Node.new "London B"
      london.add london_b
      london.add Node.new "London Bridge"

      assert london_b.has_child Node.new "London Bridge"
    end

    def test_should_own_child_even_when_grand_child_is_born
      london = Node.new "London"
      london_b = Node.new "London B"
      london.add london_b
      london.add Node.new "London Bridge"

      assert london.has_child Node.new "London B"
    end

    def test_search_for_parent_should_yield_parent_and_all_descendants

      london = Node.new "London"
      london.add Node.new "London B"
      london.add Node.new "London Bridge"

      results = london.search_for "London"
      results.each{|result| puts "found:#{result}"}

      assert_equal 3, results.size, "Expected only three elements to be found"
      assert_equal Node.new("London"), results[0], "Expected first element to be London"
      assert_equal Node.new("London B"), results[1], "Expected first element to be London"
      assert_equal Node.new("London Bridge"), results[2], "Expected first element to be London"
    end
  end
end