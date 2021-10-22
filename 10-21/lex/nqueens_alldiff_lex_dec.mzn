include "globals.mzn";

int: n; % Number of queens
array [1..n] of var 1..n: q; % Variables for queens on the rows

% Column attack constraints
constraint alldifferent(q)::domain;                       

% Diagonal attack constraints
constraint alldifferent([ q[i] + i | i in 1..n])::domain; 
constraint alldifferent([ q[i] - i | i in 1..n])::domain; 

% Integration of the Boolean model 

% Map each position i,j to a Boolean variable telling us whether there is a queen at i,j
array[1..n,1..n] of var bool: qb;

% Channeling constraint
constraint forall (i,j in 1..n) ( qb[i,j] <-> (q[i]=j) );

% Lexicographic symmetry breaking constraints on the Boolean model
constraint
    lex_lesseq(array1d(qb), [ qb[j,i] | i,j in 1..n ])
/\  lex_lesseq(array1d(qb), [ qb[i,j] | i in reverse(1..n), j in 1..n ])
/\  lex_lesseq(array1d(qb), [ qb[j,i] | i in 1..n, j in reverse(1..n) ])
/\  lex_lesseq(array1d(qb), [ qb[i,j] | i in 1..n, j in reverse(1..n) ])
/\  lex_lesseq(array1d(qb), [ qb[j,i] | i in reverse(1..n), j in 1..n ])
/\  lex_lesseq(array1d(qb), [ qb[i,j] | i,j in reverse(1..n) ])
/\  lex_lesseq(array1d(qb), [ qb[j,i] | i,j in reverse(1..n) ]);


% Decompose the lex using the AND deomposition
% Define a predicate for the AND decomposition
predicate my_lex_lesseq_and(array[int] of var int:x, array[int] of var int:y) = 
    let { int: k = length(x) } in
    forall(i in 1..k) (
      forall(j in 1..i-1) 
        (x[j] = y[j]) -> x[i] <= y[i]
    );

% constraint
%     my_lex_lesseq_and(array1d(qb), [ qb[j,i] | i,j in 1..n ])
% /\  my_lex_lesseq_and(array1d(qb), [ qb[i,j] | i in reverse(1..n), j in 1..n ])
% /\  my_lex_lesseq_and(array1d(qb), [ qb[j,i] | i in 1..n, j in reverse(1..n) ])
% /\  my_lex_lesseq_and(array1d(qb), [ qb[i,j] | i in 1..n, j in reverse(1..n) ])
% /\  my_lex_lesseq_and(array1d(qb), [ qb[j,i] | i in reverse(1..n), j in 1..n ])
% /\  my_lex_lesseq_and(array1d(qb), [ qb[i,j] | i,j in reverse(1..n) ])
% /\  my_lex_lesseq_and(array1d(qb), [ qb[j,i] | i,j in reverse(1..n) ]);


% Decompose the lex using the OR decomposition

% Define a predicate for the OR decomposition
predicate my_lex_lesseq_or(array[int] of var int:x, array[int] of var int:y) = 
  let { int: k = length(x) } in
    exists(i in 1..k) (
      forall(j in 1..i-1) (x[j] = y[j]) 
      /\ if i<k then (x[i] < y[i]) else (x[i] <= y[i]) endif
    );

% constraint
%     my_lex_lesseq_or(array1d(qb), [ qb[j,i] | i,j in 1..n ])
% /\  my_lex_lesseq_or(array1d(qb), [ qb[i,j] | i in reverse(1..n), j in 1..n ])
% /\  my_lex_lesseq_or(array1d(qb), [ qb[j,i] | i in 1..n, j in reverse(1..n) ])
% /\  my_lex_lesseq_or(array1d(qb), [ qb[i,j] | i in 1..n, j in reverse(1..n) ])
% /\  my_lex_lesseq_or(array1d(qb), [ qb[j,i] | i in reverse(1..n), j in 1..n ])
% /\  my_lex_lesseq_or(array1d(qb), [ qb[i,j] | i,j in reverse(1..n) ])
% /\  my_lex_lesseq_or(array1d(qb), [ qb[j,i] | i,j in reverse(1..n) ]);

% Search
solve :: int_search(q, input_order, indomain_min)  satisfy;

output [ if fix(q[j]) == i then "Q" else "." endif ++ if j == n then "\n" else "" endif | i,j in 1..n]
