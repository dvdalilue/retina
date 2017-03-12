class Parser

    token TRUE FALSE FUNC ID DIGITO STRING SEMICOLON COMA IGUAL PAR1 PAR2 BEGIN END FLECHA NUMBER BOOLEANO

    convert
        TRUE 'true'
        FALSE 'false'
        ID 'id'
        DIGITO 'digito'
        STRING 'string'
        SEMICOLON 'semicolon'
        COMA 'coma'
        IGUAL 'igual'
        FUNC 'func'
        PAR1 'par1'
        PAR2 'par2'
        BEGIN 'begin'
        END 'end'
        FLECHA 'flecha'
        NUMBER 'number'
        BOOLEANO 'booleano'

end

start RETINA

rule

    RETINA: DECLARACIONFUNCIONES 
          ;

    EXPRESION: 
             | TRUE  SEMICOLON   {result = Booleano.new(val[0])}
             | FALSE SEMICOLON   {result = Booleano.new(val[0])}
             | ID    SEMICOLON   {result = Identificador.new(val[0])}
             | DIGITO SEMICOLON  {result = Digito.new(val[0])}
             | STRING SEMICOLON  {result = String_.new(val[0])}
             ;

    TIPODATO:          {result = "Tipo de dato vacio?"} # Error 1
            | NUMBER   {result = TipoDato.new(val[0])}
            | BOOLEANO {result = TipoDato.new(val[0])}
            ;

    PARAMETROS: DECLARACION {result = val[0]}
              | DECLARACION COMA PARAMETROS {result = OperacionBinaria.new(val[0],val[2])}
              ;

    ASIGNACION:                    {result = "Asignacion vacía?"  } # Error 2
              | ID IGUAL EXPRESION {result = Asignacion.new(val[0], val[2])}
              ;

    DECLARACION: TIPODATO ID {result = Declaracion.new(val[0], val[1])}
               | TIPODATO ASIGNACION {result = Declaracion.new(val[0], val[1])}
               ;

    DECLARACIONFUNCIONES: 
                        | FUNC ID PAR1 PARAMETROS PAR2                 BEGIN END SEMICOLON {result = Funciones.new(val[1],val[3],val[6])}
                        | FUNC ID PAR1            PAR2                 BEGIN END SEMICOLON {result = Funciones.new(val[1],nil,val[6])}
                        | FUNC ID PAR1 PARAMETROS PAR2 FLECHA TIPODATO BEGIN END SEMICOLON {result = FuncionRet.new(val[1],val[3],val[6],val[8])}
                        ;

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