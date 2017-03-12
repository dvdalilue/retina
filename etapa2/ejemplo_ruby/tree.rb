$sub_tree_indentation = "  " # 2 spaces

class BinTree
    attr_accessor :value
    attr_accessor :left, :right

    def initialize v, l=nil, r=nil
        @value = v
        @left = l
        @right = r
    end

    def print_tree indentation="", level=0
        this_level_indentation = $sub_tree_indentation + indentation
        puts "#{indentation}Node at level #{level}:"
        puts "#{this_level_indentation}Has value: #{@value}"
        if @left
            puts "#{this_level_indentation}Left son:"
            @left.print_tree(this_level_indentation, level + 1)
        end
        if @right
            puts "#{this_level_indentation}Right son:"
            @right.print_tree(this_level_indentation, level + 1)
        end
    end
end

tree = BinTree.new(
    5,
    BinTree.new(
        3,
        BinTree.new(1)
    ),
    BinTree.new(
        6,
        BinTree.new(4),
        BinTree.new(8)
    )
)

tree.print_tree