% Combined alldifferent & symmetry breaking model

include "globals.mzn";

int: n;

% alldiff model
array[1..n] of var 1..n: row;

% Integration of the Boolean model
array[1..n, 1..n] of var 0..1: board;

% Alldiff model constraints
constraint alldifferent(row)::domain;
constraint alldifferent([row[i] + i | i in 1..n])::domain;
constraint alldifferent([row[i] - i | i in 1..n])::domain;

% Symmetry breaking model constraints
constraint
   lex_lesseq(array1d(board), [ board[j,i] | i,j in 1..n])
/\ lex_lesseq(array1d(board), [ board[i,j] | i in reverse(1..n), j in 1..n])
/\ lex_lesseq(array1d(board), [ board[j,i] | i in reverse(1..n), j in 1..n])
/\ lex_lesseq(array1d(board), [ board[i,j] | i in 1..n, j in reverse(1..n)])
/\ lex_lesseq(array1d(board), [ board[j,i] | i in 1..n, j in reverse(1..n)])
/\ lex_lesseq(array1d(board), [ board[i,j] | i,j in reverse(1..n)])
/\ lex_lesseq(array1d(board), [ board[j,i] | i,j in reverse(1..n)]);

% Channeling constraint
constraint forall (i, j in 1..n)
  (board[i,j] = 1 <-> row[i] = j);

% Search for all solutions, using N = 8, 9, 10, and 12.
solve satisfy;