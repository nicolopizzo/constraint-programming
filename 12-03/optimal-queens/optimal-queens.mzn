include "globals.mzn";
include "gecode.mzn";

int: n; % Number of queens
array [1..n] of var 1..n: q; % Variables for queens on the rows

% alldiff global constraint  
constraint alldifferent(q)::domain;                       
constraint alldifferent([ q[i] + i | i in 1..n])::domain; 
constraint alldifferent([ q[i] - i | i in 1..n])::domain; 

var int: distance = sum([abs(q[i] - i) | i in 1..n]);
% solve minimize distance;

% solve :: int_search(q, dom_w_deg, indomain_random)
%       minimize distance;

% solve :: int_search(q, dom_w_deg, indomain_random)
%       :: restart_luby(250)
%       minimize distance;

solve :: int_search(q, dom_w_deg, indomain_random)
      :: restart_luby(250)
      :: relax_and_reconstruct(q, 85)
      minimize distance;
      
output ["distance = \(distance)"];