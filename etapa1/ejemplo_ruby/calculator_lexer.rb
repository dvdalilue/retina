# Clase abstracta Token
class Token
  attr_reader :t
  
  def initialize text
    @t = text
  end

  def to_s
    "Tk#{self.class}"
  end
end

$tokens = {
  Digit:             /\A\d+/,
  Plus:              /\A\+/,
  Minus:             /\A\-/,
  Asterisk:          /\A\*/,
  Slash:             /\A\//,
  OpenRoundBracket:  /\A\(/,
  CloseRoundBracket: /\A\)/
}

class LexicographicError < RuntimeError
  def initialize t
    @t = t
  end

  def to_s
    "Unknown lexeme \'#{@t}\'"
  end
end

class Digit < Token
  def to_s
    "TkDigit(#{@t})"
  end
end

class Plus < Token; end
class Minus < Token; end
class Asterisk < Token; end
class Slash < Token; end
class OpenRoundBracket < Token; end
class CloseRoundBracket < Token; end

class Lexer
  attr_reader :tokens

  def initialize input
    @tokens = []
    @input = input
  end

  def catch_lexeme
    # Return nil, if there is no input
    return if @input.empty?
    # Ignore every white space at the begining
    @input =~ /\A\s*/
    @input = $'
    # Local variable initialize with error, if all regex don't succeed
    class_to_be_instanciated = LexicographicError # Yes, this is class. Amaze here
    # For every key and value, check if the input match with the actual regex
    $tokens.each do |k,v|
      if @input =~ v
        # Taking advantage with the reflexivity and introspection of the
        # language is nice
        class_to_be_instanciated = Object::const_get(k)
        break
      end
    end
    # Raise first error founded
    if $&.nil? and class_to_be_instanciated.eql? LexicographicError
      @input =~ /\A(\w|\p{punct})/
      raise LexicographicError.new($&)
    end
    # Append token found to the token list
    @tokens << class_to_be_instanciated.new($&)
    # Update input
    @input = @input[$&.length..@input.length-1]
    # Return token found
    return @tokens[-1]
  end
end