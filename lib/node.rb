require 'string'

module RadixTree
  class Node
    def initialize name,children=[]
      @children = children
      @name = name
    end

    def has_no_children?
      @children.empty?
    end

    def number_of_children
      @children.length
    end

    def has_children?
      !has_no_children?
    end

    def add child
      return false if !is_really_my_child? child
      add_child child
    end

    private
    def add_child child
      @children.each do |existing_child|
        if existing_child.is_sibling?(child,self)
          fork_a_new_child_and_add_to_children existing_child, child
          return
        end
      end
      @children << child
      true
    end

    def fork_a_new_child_and_add_to_children existing_child,new_child
      new_parent = existing_child.fork_a_new_parent_and_add new_child
      @children.delete existing_child
      @children << new_parent
    end

    protected
    def is_sibling? other,parent
      common_beginning_name=other.name.common_beginning(@name)
      return false if common_beginning_name.nil?
      common_beginning_name.chomp!(separator=' ')
      new_found_parent = Node.new common_beginning_name
      result = !(new_found_parent == parent)
      result
    end

    def add_blindly child
      @children << child
    end

    def fork_a_new_parent_and_add child
      new_parent=Node.new @name.common_beginning child.name
      new_parent.add_blindly child
      new_parent.add_blindly self
      new_parent
    end

    def is_really_my_child? child
      child.name.starts_with @name
    end

    public
    def == other
      @name == other.name
    end

    def to_s
      @name
    end

    protected
    attr_reader :name
  end
end
