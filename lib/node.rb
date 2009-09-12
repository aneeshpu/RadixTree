module PredictiveSearch
  class Node
    def initialize(name=nil,children=[])
      @children=children
      @name=name
    end

    def self.root
      Node.new "root", ('a'..'z').to_a
    end

    def add(child)
      merge_with child if has_no_children?
      @children.each { |existing_child| existing_child.add(child) if existing_child.is_ancestor_of? child }
      self
    end

    def has_children
      !@children.empty?
    end

    def has_no_children
      @children.empty?
    end

    def number_of_children
      @children.length
    end

    protected 
    def is_ancestor_of? child
      child.name <=> @name >= 0
    end

    private
    def merge_with child
      #mutation is bad...
      @name=child.name
    end

    attr_reader :name
  end
end
