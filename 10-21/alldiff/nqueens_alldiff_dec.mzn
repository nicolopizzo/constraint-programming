% Alldiff decomposition model

include "alldifferent.mzn";

int: n; % Number of queens
array [1..n] of var 1..n: q; % Variables for queens on the rows

% alldiff global constraint  
constraint alldifferent(q)::domain;                       
constraint alldifferent([ q[i] + i | i in 1..n])::domain; 
constraint alldifferent([ q[i] - i | i in 1..n])::domain; 

% decompose the alldiff constraints
% constraint forall(i, j in 1..n where i < j) (q[i] != q[j]);
% constraint forall(i, j in 1..n where i < j) (q[i] + i != q[j] + j);
% constraint forall(i, j in 1..n where i < j) (q[i] - i != q[j] - j);


solve :: int_search(q, input_order, indomain_min)  satisfy;
