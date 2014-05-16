%% ------------------ Functions made just as an exercise ----------------------

%% 1. Rasti priešpaskutinį sąrašo elementą
before_last([]) :- !.
before_last([E,_]) :- write(E).
before_last([_|E]) :- before_last(E).

%% 2. Rasti antrą sąrašo elementą
seconds_element([]) :- !.
seconds_element([_,E|_]) :- write(E).

%% 3. Suformuoti 1 lygio šąrašo elementą iš keleto lygio sąrašo (f-cija flatten). Galima naudoti predikatus is_list/1 ir append/3, spręsti rekursiškai
flat_list([], []) :- !.
flat_list([L|Ls], FlatL) :- 
	!,
    flat_list(L, NewL),
    flat_list(Ls, NewLs),
    append(NewL, NewLs, FlatL).
flat_list(L, [L]).

%% 4. Raskite k-tąjį sąrašo narį, kai sąrašas m pradedamas nuo 1 (indeksas)
nth_member([],_) :- !.
nth_member([M|_],1) :- write(M).
nth_member([_|M],N) :- 
	NC is N - 1, 
	nth_member(M,NC).

%% 5. Ištrinkite iš sąrašo iš eilės pasikartojančius narius, paliekant po vieną tokį narį
delete([],_,[]) :- !.
delete([H|T],H,TN) :- delete(T,H,TN).
delete([H|T],E,[H|TN]) :- \+ H=E, delete(T,E,TN).

unique([],[]) :- !.
unique([H|T],[H|TU]) :- 
	delete(T,H,TN), 
	unique(TN,TU).

%% 7. Suskaičiuokite sąrašo elementus, tuos, kurie nėra skaičiai
count_non_numbers(List) :- count_non_numbers(List,0).
count_non_numbers([],C) :- write(C).
count_non_numbers([S|List], C) :- 
	\+ number(S), 
	!,
	NC is C + 1, 
	count_non_numbers(List,NC).
count_non_numbers([_|List], C) :- count_non_numbers(List,C).

%% 8. Rekursiškai suskaičiuokite sąrašų (bet kokio gylio) sveikų skaičių sumą
recursive_sum(L) :- recursive_sum(0,L,0).
recursive_sum(X,[],_) :- write(X).
recursive_sum(N, [Head|Tail], Y) :- N1 is Head + N, recursive_sum(N1,Tail,Y).

%% ------------------------- Assignment Functions -----------------------------

%% 6. Suskaičiuokite sarašo elementus, tuos, kurie yra skaičiai
count_numbers(List) :- count_numbers(List,0).
count_numbers([],C) :- write(C).
count_numbers([S|List], C) :- 
	number(S), 
	!,
	NC is C + 1, 
	count_numbers(List,NC).
count_numbers([_|List], C) :- count_numbers(List,C).

%% 10. Suskaičiuokite dviejų dimensijų sąrašo bendrą elementų ilgį
collective_length(LS, P) :- collective_length(LS, 0, P).
collective_length([], L, L) :- !.
collective_length([NS|LS], L, P) :-
	!,
	collective_length(NS, L, F),
	collective_length(LS, L, S),
	P is F + S.
collective_length(_, L, P) :- P is L + 1.

%% --------------------------- Main & Test Data -------------------------------

:- initialization(main).
main :-
 	count_numbers([1,a,2,b,3,5,100,e,d]), nl,
 	collective_length([1,[2,3,[4,2,3]],5,[6,7]], X), write(X), nl, %28
 	halt.