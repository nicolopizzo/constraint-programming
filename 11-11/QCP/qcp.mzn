% Use this editor as a MiniZinc scratch book
include "globals.mzn";

int: N; % size
array[1..N,1..N] of 0..N: start;

array[1..N,1..N] of var 1..N: qc;


% Start conditions where start[i,j] > 0
constraint forall(i,j in 1..N where start[i,j] > 0) (qc[i,j] = start[i,j]);

% Alldifferent on the rows
constraint forall(i in 1..N) (alldifferent([qc[i,j] | j in 1..N]))::domain;

% Alldifferent on the columns
constraint forall(j in 1..N) (alldifferent([qc[i,j] | i in 1..N]))::domain;

% solve satisfy;

solve :: int_search(qc, dom_w_deg, indomain_random) satisfy;

% solve :: int_search(qc, dom_w_deg, indomain_random)
%       :: restart_luby(250)
%          satisfy;