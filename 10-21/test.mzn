include "globals.mzn";

int: n;
array[1..n] of var 0..1: x;
array[1..n] of var 0..1: y;

predicate my_lex_lesseq_and(array[int] of var int:x, array[int] of var int:y) = 
    let { int: k = length(x) } in
    forall(i in 1..k) (
      forall(j in 1..i-1) 
        (x[j] = y[j]) -> x[i] <= y[i]
    );
    
predicate my_lex_lesseq_or(array[int] of var int:x, array[int] of var int:y) = 
  let { int: k = length(x) } in
    exists(i in 1..k) (
      forall(j in 1..i-1) (x[j] = y[j]) 
      /\ if i<k then (x[i] < y[i]) else (x[i] <= y[i]) endif
    );
    
% constraint lex_lesseq(x, y);
% constraint my_lex_lesseq_and(x, y);
% constraint my_lex_lesseq_or(x, y);

solve satisfy;