% Alldifferent model

include "alldifferent.mzn";

int: n; % Number of queens
array [1..n] of var 1..n: q; % Variables for queens on the rows (or columns)

% Column attack and Diagonal attack constraints using the alldifferent constraint
% Append ::domain to the end.
constraint alldifferent(q)::domain;
constraint alldifferent([q[i] + i | i in 1..n])::domain;
constraint alldifferent([q[i] - i | i in 1..n])::domain;

% Search for all solutions, using N = 8, 9, 10, and 12.
solve satisfy;