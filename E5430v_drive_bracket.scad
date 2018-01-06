//
// Dell E5430v Laptop Drive Bracket by Russ Hughes (russ@owt.com)
// Aug 26, 2017
// Creative Commons - Attribution
//

$fn = 16;
thick = 0.2*6;
width = 7;
half_width = width / 2;
height = 1.5;
ll = 0;
lr = 1;
ul = 2;
ur = 3;

x = 0;
y = 1;

case = [
	[3.07, -3.93],	// ll
	[74.29, 6.5],	// lr
	[-4.43, 99.1],	// ul
	[74.79, 97.6]	// ur
];

drive = [
	[4.07, 14],			// ll
	[65.79, 14],		// lr
	[4.07, 90.6],		// ul
	[65.79, 90.6]		// ur
];

module hole() {
	cylinder(d=3.6, h=thick+3);
}

module frame() {
	// upper left case tab
	translate([case[ul][x], case[ul][y] - half_width , 0]) 
		cube([drive[ul][x] + abs(case[ul][x]), width, thick]);
		
	// left vertical 
	llen = 	case[ul][y] + abs(case[ll][y])+width-5;
	translate([drive[ul][x] - half_width, case[ul][y] - llen + half_width, 0])
		cube([width, llen, thick]);

	// upper right case tab

	translate([drive[ur][x], case[ur][y] - half_width, 0])
		cube([case[ur][x] - drive[ur][x], width, thick]);

	// right verticle
	rlen = case[ur][y] - case[lr][y] + width;
	translate([drive[ur][x] - half_width, case[ur][y] - rlen + half_width, 0])
		cube([width, rlen, thick]);

	// lower right case tab

	translate([drive[lr][x]-half_width, case[lr][y]-half_width, 0])
		cube([case[lr][x] - drive[lr][x]+half_width, width, thick]);

	// upper  horizontal
	translate([drive[ul][x], drive[ul][y]-half_width, 0])
		cube([drive[ur][x] - drive[ul][x], width, thick]); 

	// lower horizontal
	translate([drive[ll][x], drive[ll][y]-half_width, 0])
		cube([drive[lr][x] - drive[ll][x], width, thick]); 

	// rounded end standoffs 
	for (i = [0 : 3]) {
		translate([case[i][x],case[i][y], -height])
			cylinder(d=7, h=thick+height);
	}
}

module holes() {
	for (i = [0 : 3]) {
		
		// case holes
		translate([case[i][x],case[i][y], -height]) {
			hole();
			translate([0,0,height])
				cylinder(d2=6.5+0.4, d1=3.6, h=3);
		}
		
		// drive holes
		translate([drive[i][x],drive[i][y], -height]) {
			hole();
			translate([0,0,height])
				cylinder(d2=6.5+0.4, d1=3.6, h=3);
		}
	}
	
	translate([case[ll][x]+3.125,case[ll][y]+1.5, 0])
	rotate([0,0,-10])
		cube([1.5,8,thick]);	
}

rotate([0,180,0]) {
	difference() {
		frame();
		holes();
	}
}