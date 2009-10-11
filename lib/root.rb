# To change this template, choose Tools | Templates
# and open the template in the editor.

module RadixTree
  class Root < Node
    def initialize name
      super(name)
    end

    protected
    def is_really_my_child? child
      true
    end
  end
end
