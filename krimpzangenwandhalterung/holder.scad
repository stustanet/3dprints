use <ssn/tools.scad>

$fn = 25;

opening = 65;
grip_width = 5;
hook_length = 70;
wall_thickness = 7;

module wallmount(d1, d2, l, h) {
	translate([0, h/2, 0])
	rotate([0,90,90]) {
		hull() {
			cylinder(d=d2, h=h, center=true);
			translate([-l - d2, 0, 0]) cylinder(d=d2, h=h, center=true);
		}
		cylinder(d=d1, h=h, center=true);
	}
}

module holder() {
	difference () {
		union ()  {
			hull() {
				// Wall part
				translate([0,0,-30]) cube([opening + 2*grip_width, 5, 30]);
				cube([opening + 2*grip_width, hook_length + wall_thickness, 5]);

			}
			translate([0, hook_length + wall_thickness/2 + 0.2, 5])
			rotate([0, 90, 0])
			cylinder(d=11.8, h=opening + 2*grip_width);
		}
		translate([5, wall_thickness, -50]) rounded_cube_flat([opening, hook_length + 10, 100], r=5);

		// Mounting holes
		translate([wall_thickness + opening - 15, -0.1, -20]) {
			wallmount(d1=10, d2=4, l=6, h=10);
			translate([0, 4, 0]) wallmount(d1=12, d2=8, l=5, h=10);
		}

		translate([wall_thickness + 10, -0.1, -20]) {
			wallmount(d1=10, d2=4, l=6, h=10);
			translate([0, 4, 0]) wallmount(d1=12, d2=8, l=5, h=10);
		}
	}
}

holder();
