RACC = racc
PARSER = calculator_parser.y

calculator_parser.rb: ${PARSER}
	${RACC} $< -o $@

clean:
	rm calculator_parser.rb