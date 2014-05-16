:- initialization(main).

calc(X) :- C is X * X * X, write(C).

do_list(N, L):- findall(Num, between(1, N, Num), L).

mylist([a,b,c]).
myprog(X) :- mylist(L), member(X, L), write(X).

print(0, _) :- !.
print(_, []).
print(N, [H|T]) :- write(H), nl, N1 is N - 1, print(N1, T).

main :- write('Hello World!'), myprog(X), nl, halt.