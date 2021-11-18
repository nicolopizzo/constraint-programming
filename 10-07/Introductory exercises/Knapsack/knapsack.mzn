enum ITEM; %items to pack
int: capacity; %knapsack capacity

array[ITEM] of int: profits; %item profits
array[ITEM] of int: weights; %item weights

var set of ITEM: knapsack; %a set variable for the sack
var int: totalProfit; %objective function 
 
constraint sum (i in knapsack) (weights[i]) <= capacity;
constraint totalProfit = sum (i in knapsack) (profits[i]);

solve maximize totalProfit;

output ["knapsack = \(knapsack)\n", "Total Profit = ", show(totalProfit)];