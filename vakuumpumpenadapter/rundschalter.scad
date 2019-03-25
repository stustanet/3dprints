wall=2;
$fn=100;

module switch() {
	// upper cube
	translate([0,0,-3.6-2.7-8.5]) {
		// Moving rod
		translate([0,0, 3.6+2.7+8.5])
		cylinder(d=8, h=7.3);

		// Holding washer
		translate([0,0,3.6])
		cylinder(d=16, h=2.7);

		// screw
		translate([0,0,3.6+2.7])
		cylinder(d=11.7, h=8.5);

		cube([24, 16.5, 7.2], center=true);

		// Smaller lower cube
		translate([0,0,-(7.2 + 10)/2])
		cube([20,13,10], center=true);

		// Connector 1a
		translate([7.5,0,-(7.2/2) - 10 - 4])
		cube([1, 5, 8], center=true);

		// Connector 1
		translate([0,0,-(7.2/2) - 10 - 4])
		cube([1, 5, 8], center=true);
	}
}

module basement_bottom() {
	difference() {
		cylinder(d=40, h=20+wall);

		// the switch
		translate([0,0,10+wall+1])
		cube([20, 13.5, 21], center=true);

		// the wire
		translate([0,0,2+2+wall])
		rotate([0,-99,0])
		cylinder(d=4, h=25, $fn=9);
	}
}

module basement_top() {
	// ?????????????????????????????????
}

module switch_top() {
	difference () {
		sphere(d=60, $fn=30);
		translate([0,0,-35])
		cube([70, 70, 70], center=true);

		translate([0,0,-0.1])
		cylinder(d=41, h=14.1+wall);

		translate([0,0,13.99+wall])
		cylinder(d1=41, d2=8, h=8);

		#translate([0,0,13.98+8+wall])
		cylinder(d=8, h=3);
	}
}

difference() {
switch_top();
translate([-50,0,-10])
cube([100, 100, 100]);
}
!basement_bottom();

// translate([0,0,-5]) basement_bottom();


//translate([0,0,33+5+wall]) switch();
