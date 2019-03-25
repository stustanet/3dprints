use <ssn/tools.scad>

module conditional_subtract(screw_length) {
	if (screw_length == 0) {
		difference() {
			for (i = [0:1:$children-1]) {
				children(i);
			}
		}
	} else {
		for (i = [0:1:$children-1]) {
			children(i);
		}
	}
}

module fan(screw_length=0) {
	$fn=20;
	cube([41, 41, 28]);
	translate([33/2 + 4, 33/2 + 4, -screw_length])
	squareUp([36/2, 36/2, 0]) {
		cylinder(d=3., h=screw_length*2);
	}
}


module nozzle() {
	difference() {
		hull() {
			translate([-2, -2, 0])
			cube([45, 45, 30]);

			translate([41/2, 41/2, 100])
			cylinder(d=15, h=0.1);
		}
		hull() {
			fan(0);
			translate([41/2, 41/2, 100])
			cylinder(d=12, h=0.1);

		}
	}
}

nozzle();
