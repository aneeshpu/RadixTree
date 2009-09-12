# To change this template, choose Tools | Templates
# and open the template in the editor.

$:.unshift File.join(File.dirname(__FILE__),'..','lib')

require 'test/unit'
require 'string'

module RadixTree
  class StringTest < Test::Unit::TestCase
    def test_starts_with
      assert "London".starts_with "Lon"
    end

    def test_share_a_common_beginning
      assert_equal("London B", "London Bridge".common_beginning("London Blackfriars"))
      assert_equal("Lon", "London".common_beginning("Loncashire"))
      assert_equal("", "London".common_beginning("Timbuktoo"))
    end
  end
end
