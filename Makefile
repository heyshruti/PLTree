CC = gcc
CFLAGS = -Wall -g

TARFILES = Makefile scanner.mll parser.mly ast.mli calc.ml

OBJS = parser.cmo scanner.cmo calc.cmo
ALLOBJS = ast.cmo cast.cmo sast.cmo parser.cmo scanner.cmo compile.cmo execute.cmo pltree.cmo

pltree: $(ALLOBJS)
	ocamlc -o pltree $(ALLOBJS)

calc : $(OBJS)
	ocamlc -o calc $(OBJS)

scanner.ml : scanner.mll
	ocamllex scanner.mll

parser.ml parser.mli : parser.mly
	ocamlyacc parser.mly

%.cmo : %.ml
	ocamlc -c $<

%.cmi : %.mli
	ocamlc -c $<


.PHONY : menhir
menhir:
	menhir -v parser.mly

.SECONDARY:

%: %.o tree.o ll.o
	$(CC) $(CFLAGS) -o $@ $< tree.o ll.o

%.o: %.c %.h
	$(CC) $(CFLAGS) -c $< -o $@

%.c: %.tree pltree
	cat $< | ./pltree -c > $@

calculator.tar.gz : $(TARFILES)
	cd .. && tar zcf calculator/calculator.tar.gz $(TARFILES:%=calculator/%)

.PHONY : clean
clean :
	rm -f calc pltree parser.ml parser.mli scanner.ml
	rm -f *.cmo *.cmi hello hello.c gcd.c gcd tree *.o ll
	rm -f *.automaton *.conflicts

# Generated by ocamldep *.ml *.mli
ast.cmo :
ast.cmx :
calc.cmo : scanner.cmo parser.cmi ast.cmo
calc.cmx : scanner.cmx parser.cmx ast.cmx
cast.cmo :
cast.cmx :
compile.cmo : sast.cmo ast.cmo
compile.cmx : sast.cmx ast.cmx
execute.cmo : sast.cmo cast.cmo
execute.cmx : sast.cmx cast.cmx
parser.cmo : ast.cmo parser.cmi
parser.cmx : ast.cmx parser.cmi
pltree.cmo : scanner.cmo parser.cmi execute.cmo compile.cmo ast.cmo
pltree.cmx : scanner.cmx parser.cmx execute.cmx compile.cmx ast.cmx
read.cmo : scanner.cmo parser.cmi ast.cmo
read.cmx : scanner.cmx parser.cmx ast.cmx
read_tree.cmo : scanner.cmo parser.cmi
read_tree.cmx : scanner.cmx parser.cmx
sast.cmo :
sast.cmx :
scanner.cmo : parser.cmi
scanner.cmx : parser.cmx
parser.cmi : ast.cmo
