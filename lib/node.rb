require 'string'
require 'not_my_child_error'

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
      raise NotMyChildError, "#{child} is not a child of #{self}" if !is_really_my_child? child
      
      add_child child
    end

    private
    def add_child child
      
      @children.each do |existing_child|

        if existing_child.is_really_my_child? child
          existing_child.add child
          return
        end

        if existing_child.is_sibling_of_new_child_to_be_added? child,self
          fork_a_new_parent_and_add_to_children existing_child, child
          return
        end
        
      end

      accept_as_own_child child
    end

    def fork_a_new_parent_and_add_to_children existing_child,new_child
      new_parent = existing_child.fork_a_new_parent_and_add new_child
      
      disown_existing_child existing_child
      
      add_new_child new_parent
    end

    private
    def add_new_child new_child
      @children << new_child
    end

    private
    def disown_existing_child existing_child
      @children.delete existing_child
      self
    end

    protected
    def is_sibling_of_new_child_to_be_added? other,parent
      common_beginning_name = common_beginning_in_name other.name
      return false if common_beginning_name.nil?
      
      common_beginning_name.chomp!(separator=' ')
      new_found_parent = Node.new common_beginning_name
      result = !(new_found_parent == parent)
      result
    end

    def accept_as_own_child child
      @children << child
    end

    def fork_a_new_parent_and_add child
      new_parent=Node.new @name.common_beginning child.name
      new_parent.accept_as_own_child child
      new_parent.accept_as_own_child self
      new_parent
    end

    def is_really_my_child? child
      child.name.starts_with @name
    end

    private
    def common_beginning_in_name other_name
      return @name.common_beginning other_name
    end

    def names_have_a_common_beginning? other_name
      return !@name.common_beginning(other_name).nil?
    end

    public
    def == other
      return false if other == nil
      @name == other.name
    end

    def to_s
      @name
    end

    protected
    attr_reader :name

    public
    def tree_string
      tree_string = @name
      @children.each { |child| 
          tree_string = "#{tree_string}\n|\n|__" << child.tree_string
        }
      tree_string
    end

    def has_child(purportedChild)
      @children.include? purportedChild
    end

    def find_child purportedChild
      @children.find {|child| child == purportedChild}
    end

    def search_for node_name

      if node_name.starts_with @name
        return add_me_and_my_descendants
      end

    end

    protected
    def add_me_and_my_descendants
      me_and_my_descendants = [self]

      @children.each do |child|
        me_and_my_descendants.concat(child.add_me_and_my_descendants)
      end

      return me_and_my_descendants
    end
  end
end

