# To change this template, choose Tools | Templates
# and open the template in the editor.

module RadixTree
  class NotMyChildError < RuntimeError
    def initialize(message)
      super message
    end
  end
end
