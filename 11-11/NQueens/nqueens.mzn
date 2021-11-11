% Use this editor as a MiniZinc scratch book

include "alldifferent.mzn";

int: n; % Number of queens
array [1..n] of var 1..n: q; % Variables for queens on the rows (or columns)

% Column attack and Diagonal attack constraints using the alldifferent constraint
% Append ::domain to the end.
constraint alldifferent(q)::domain;
constraint alldifferent([q[i] + i | i in 1..n])::domain;
constraint alldifferent([q[i] - i | i in 1..n])::domain;

% solve :: int_search(q, input_order, indomain_min) satisfy;
% solve :: int_search(q, first_fail, indomain_min) satisfy;
% solve :: int_search(q, input_order, indomain_random) satisfy;
solve :: int_search(q, dom_w_deg, indomain_random) satisfy;