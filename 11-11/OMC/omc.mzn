% Use this editor as a MiniZinc scratch book
include "globals.mzn";

int: colors;
int: n;
int: e;
array[1..e] of 1..n: start;
array[1..e] of 1..n: end;

array[1..n] of var 1..colors: cm; % color map

% Impose the neighbours are different
constraint forall(j in 1..e) ( cm[start[j]] != cm[end[j]] );

constraint forall(i in 1..colors-1) ( 
  value_precede(i, i+1, cm)
);

var 1..n: nc = max(cm);

solve minimize nc;

output ["Optimal number of colors: \(nc)\n\(cm)"];