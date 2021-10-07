int: nc = 6; %number of colours

%variables for regions
var 1..nc: wa;   var 1..nc: nt;  var 1..nc: sa;   var 1..nc: q;
var 1..nc: nsw;  var 1..nc: v;   var 1..nc: t;

%difference constraints
constraint wa != nt;
constraint wa != sa;
constraint nt != sa;
constraint nt != q;
constraint sa != q;
constraint sa != nsw;
constraint sa != v;
constraint q != nsw;
constraint nsw != v;

solve satisfy;

output["wa = ",show(wa),"\n",
"nt = ",show(nt),"\n", 
"sa = ",show(sa),"\n",
"q = ",show(q),"\n",
"nsw = ",show(nsw),"\n",
"v = ",show(v),"\n",
"t = ",show(t),"\n",
];


