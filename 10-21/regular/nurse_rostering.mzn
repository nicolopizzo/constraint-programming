include "globals.mzn";
enum NURSE;
enum DAY;
int: req_day;
int: req_night;
int: min_night;

enum SHIFT = { d, n, o };
int: S = card(SHIFT);

int: Q = 6; int: q0 = 1; set of int: STATE = 1..Q;
array[STATE,SHIFT] of int: t =
     [| 2, 3, 1    % state 1
      | 4, 4, 1    % state 2
      | 4, 5, 1    % state 3
      | 6, 6, 1    % state 4
      | 6, 0, 1    % state 5
      | 0, 0, 1|]; % state 6 

array[NURSE,DAY] of var SHIFT: roster;

% constraint forall(j in DAY)(
%              sum(i in NURSE)(roster[i,j] == d) == req_day /\
%              sum(i in NURSE)(roster[i,j] == n) == req_night
%            );
% constraint forall(i in NURSE)(
%              regular([roster[i,j] | j in DAY], Q, S, t, q0, STATE)
%              /\ sum(j in DAY)(roster[i,j] == n) >= min_night
%            );

% globalize the first two sums constraints
constraint forall(j in DAY) (
% They are all good, but distribute should be better. 
% The three methods seem equivalent because of the results, but I think
% distribute is better because it's more concise and easier to read.
% Also, you don't need to explicitly specify the conjunction

% 1. Conjunction of count_eq
%   count_eq([roster[i,j] | i in NURSE], d, req_day) /\
%   count_eq([roster[i,j] | i in NURSE], n, req_night)

% 2. Conjunction of among
%   among(req_day, [roster[i,j] | i in NURSE], {d}) /\
%   among(req_night, [roster[i,j] | i in NURSE], {n})

% 3. Using Distribute  
  distribute([req_day, req_night], [d, n], [roster[i,j] | i in NURSE])::domain
);

% globalize the third sum constraint
constraint forall(i in NURSE) (
  regular([roster[i,j] | j in DAY], Q, S, t, q0, STATE) /\
  count_leq([roster[i,j] | j in DAY], n, min_night)::domain
);

solve satisfy;

output [ show(roster[i,j]) ++ if j==card(DAY) then "\n" else " " endif
       | i in NURSE, j in DAY ]; 