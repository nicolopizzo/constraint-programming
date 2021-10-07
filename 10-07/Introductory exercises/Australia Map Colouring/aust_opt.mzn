% number of colours available
int: nc = 6;

% variables mapping states to colours
var 1..nc: wa; var 1..nc: nt;
var 1..nc: sa; var 1..nc: q;
var 1..nc: nsw; var 1..nc: v;
var 1..nc: t;

% adjacent states have different
% colours

constraint wa != nt;
constraint wa != sa;
constraint nt != sa;
constraint nt != q;
constraint sa != q;
constraint sa != nsw;
constraint sa != v;
constraint q != nsw;
constraint nsw != v;

% minimize the total number of colours used
solve minimize max([wa,nt,sa,q,nsw,v,t]);