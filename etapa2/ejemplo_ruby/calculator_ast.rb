class AST
    def print_ast indent=""
        puts "#{indent}#{self.class}:"

        attrs.each do |a|
            a.print_ast indent + "  " if a.respond_to? :print_ast
        end
    end

    def attrs
        instance_variables.map do |a|
            instance_variable_get a
        end
    end
end

class Number < AST
    attr_accessor :digit

    def initialize d 
        @digit = d
    end

    def print_ast indent=""
        puts "#{indent}#{self.class}: #{@digit.to_i}"
    end
end

class ArithmeticUnOP < AST
    attr_accessor :operand

    def initialize operand
        @operand = operand
    end
end

class ArithmeticBinOP < AST
    attr_accessor :left, :right

    def initialize lh, rh
        @left = lh
        @right = rh
    end
end

class UnaryMinus < ArithmeticUnOP;end
class Addition < ArithmeticBinOP;end
class Subtraction < ArithmeticBinOP;end
class Multiplication < ArithmeticBinOP;end
class Division < ArithmeticBinOP;end