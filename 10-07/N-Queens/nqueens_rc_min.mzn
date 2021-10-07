% Minimal combined row and column model

include "alldifferent.mzn";
include "inverse.mzn";

int: n; % Number of queens
array [1..n] of var 1..n: rows; % Variables for queens on the rows
array [1..n] of var 1..n: cols; % Variables for queens on the columns

% Diagonal attack constraints from one model
constraint forall( i,j in 1..n where i < j )
        ( abs(rows[i] - rows[j]) != abs(i-j) );

% Channeling constraint
constraint inverse(rows, cols);

% Search for all solutions, using N = 8, 9, 10, and 12.
solve satisfy;