class Parser

    token 'digit' '+' '-' '*' '/' '(' ')' UMINUS

    prechigh
        nonassoc UMINUS
        left '*' '/'
        left '+' '-'
    preclow

    convert
        'digit' 'Digit'
        '+'     'Plus'
        '-'     'Minus'
        '*'     'Asterisk'
        '/'     'Slash'
        '('     'OpenRoundBracket'
        ')'     'CloseRoundBracket'
end

start Calculator

rule
    
    Calculator: Expression
              ;

    Expression: 'digit'                     { result = Number.new(val[0])                 }
              | '-' Expression = UMINUS     { result = UnaryMinus.new(val[1])             }
              | Expression '+' Expression   { result = Addition.new(val[0], val[2])       }
              | Expression '-' Expression   { result = Subtraction.new(val[0], val[2])    }
              | Expression '*' Expression   { result = Multiplication.new(val[0], val[2]) }
              | Expression '/' Expression   { result = Division.new(val[0], val[2])       }
              | '(' Expression ')'          { result = val[1]                             }
              ;

---- header

require_relative "calculator_lexer"
require_relative "calculator_ast"

class SyntacticError < RuntimeError

    def initialize(tok)
        @token = tok
    end

    def to_s
        "Syntactic error on: #{@token}"   
    end
end

---- inner

def on_error(id, token, stack)
    raise SyntacticError::new(token)
end
   
def next_token
    token = @lexer.catch_lexeme
    return [false,false] unless token
    return [token.class,token]
end
   
def parse(lexer)
    @yydebug = true
    @lexer = lexer
    @tokens = []
    ast = do_parse
    return ast
end