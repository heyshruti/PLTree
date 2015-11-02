open Ast

let rec eval = function 
	Lit(x) -> print_endline x
|	Int(x) -> print_endline (string_of_int x)


let _ = 
	let lexbuf = Lexing.from_channel stdin in
	let expr = Parser.expr Scanner.token lexbuf in
	let result = eval expr in
	result
