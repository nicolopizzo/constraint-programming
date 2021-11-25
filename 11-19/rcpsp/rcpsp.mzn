include "globals.mzn";

int: n_tasks;   % Number of tasks
set of int: TASKS = 1..n_tasks;  
array[TASKS] of int: duration; % Task durations

int: n_res;   % Number of resources
set of int: RESOURCES = 1..n_res; 
array[RESOURCES] of int: L; % Resource capacities
array[RESOURCES,TASKS] of int: req; %Resource requirements of tasks

int: p;       % Number of precedence relations
set of int: PREC = 1..p;
array[PREC,1..2] of TASKS: pre; % Precedence relations

% The maximum starting time is the sum of the duration except for the minimum. In fact, the worst case scenario
% is a linear sequence of all the actions where the last action is the one with the minimum duration.
int: min_time = min(duration);
int: max_time = sum(duration) - min_time;

array[TASKS] of var 0..max_time: S;

% Precedence constraint
constraint forall ( i in PREC ) (
    let { int: x = pre[i,1]; int: y = pre[i,2]; } in
    S[x] + duration[x] <= S[y]
);

% Cumulative constraint for each resource
constraint forall ( i in RESOURCES ) (
    let { array[TASKS] of int: R = [req[i,j] | j in TASKS]; } in
    cumulative(S, duration, R, L[i])
);

int: max_makespan = max_time + min_time;

var min_time..max_makespan: makespan = max([S[i] + duration[i] | i in TASKS]);
% solve minimize makespan;

solve :: int_search(S, smallest, indomain_min) minimize makespan;

output ["makespan = \(makespan)"];
