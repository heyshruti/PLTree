type expr =
	Lit of string
|	FunCall of string * expr
|	While of expr * expr
|	Seq of expr * expr
|	IntVarDec of string * expr
|	Eq of string * string
|	Lt of string * string
|	Assn of string * expr
|	Add of string * string
