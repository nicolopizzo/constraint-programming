include "globals.mzn";

int: M;     %number of machines = number of tasks
int: J;     %number of jobs
set of int: MACH = 1..M;
set of int: TASK = 1..M; 
set of int: JOB = 1..J;
array[JOB, TASK] of MACH: machine;    % machines for tasks
array[JOB, MACH] of int: duration;     % task durations on machines

% The worst case scenario is the one where the activities with the maximum duration for each job are not done
% in parallel, and the last activity to be done is the one with the minimum duration.
int: min_time = min(duration);
int: max_time = sum(duration) - min_time;


array[JOB, TASK] of var 0..max_time: S;

% auxiliary array
array[JOB, TASK] of int: tasksDuration = array2d(JOB, TASK, [ duration[i, machine[i,j]] | i in JOB, j in TASK ]);

% Precedence constraint
constraint forall( i in JOB ) (
  forall (j in 1..M-1) (S[i,j] + tasksDuration[i,j] <= S[i,j+1])
);

% Disjunctive constraint for each machine
constraint forall( j in MACH ) (
  disjunctive( [S[i, k] | i in JOB, k in TASK where machine[i,k] = j],
               [duration[i, j] | i in JOB] )
);

int: max_makespan = max_time + min_time;

var min_time..max_makespan: makespan;
constraint forall(i in JOB) (S[i, M] + tasksDuration[i, M] <= makespan);

solve minimize makespan;
% solve :: int_search(S, smallest, indomain_min) minimize makespan;
output ["makespan = \(makespan)"];