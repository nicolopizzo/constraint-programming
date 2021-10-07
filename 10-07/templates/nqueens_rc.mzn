% First combined row and column model

include "alldifferent.mzn";
include "inverse.mzn";


int: n; % Number of queens
array [1..n] of var 1..n: rows; % Variables for queens on the rows
array [1..n] of var 1..n: cols; % Variables for queens on the columns

% Column attack constraints using the alldifferent constraint from both models
% Append ::domain to the end.  


% Diagonal attack constraints from both models


% Channeling constraint


% Search for all solutions, using N = 8, 9, 10, and 12.
solve satisfy;