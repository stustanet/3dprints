use <ssn/tools.scad>
use <ssn/ssn.scad>

$fn=100;
module camera() {
	//14
	tZ(14)
	difference() {
		translate([0, 0, 1])
		cube([30, 24, 2], center=true);

		squareUp([23.5/2, 23.5/2, -0.1])
		cylinder(d=2.5, h=3);
	}

	cylinder(d=12, h=14.5);
}

module microscope() {
	tZ(-11) {
		cylinder(d=37.5, h=11);
		tZ(-60)
		cylinder(d=60, h=60);
	}
}

module mount() {
	tZ(-11)
	difference() {
		cylinder(d=45, h=11+14);
		cylinder(d=38, h=11+14-3);
		cylinder(d=22, h=11+14);

		tZ(11+14-3)
		squareUp([23.5/2, 23.5/2, -0.1]) {
			// M3 screwhead
			tZ(-4)
			cylinder(d=6.6, h = 6, $fn=6);
			cylinder(d=3, h=10);
		}


		tZ(14+11+2.5+0.3)
		translate([0, 0, 0])
		rotate([90, 0, 0])
		cylinder(d=4, h=40);

		num = 60;
		for (i=[0:1:num]) {
			rotate([0, 0, (360/num)*i])
			translate([22, 0, 0])
			rotate([0, 0, 42])
			//cube([2, 2, 20]);
			cylinder(d=3, h=25);
		}
	}
}

module lid() {
	difference() {
		tZ(14) cylinder(d=45, h=4);
		#tZ(15) cube([30.5, 24.5, 3], center=true);

		tZ(13.9)
		translate([0, 0, 0])
		rotate([90, 0, 0])
		cylinder(d=4, h=40);

		tZ(14)
		squareUp([23.5/2, 23.5/2, -0.1])
		cylinder(d=2.5, h=10);

		tZ(17.7)
		translate([-1, 0, 0])
		#stustanet_logo(0.3);
		difference() {
			tZ(18) cube([42, 10, 0.6], center=true);
			tZ(18) cube([41.7, 9.7, 0.6], center=true);
		}

	}
}

lid();
//mount();
//microscope();
//camera();
