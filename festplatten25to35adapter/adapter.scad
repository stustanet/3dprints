// 2019 by Johannes Walcher
//
// Defines an 3.5'' to 2.5'' adapter for server slots.
// Should not be used with hdds, since it will only fix it on one side and
// is not suitable agains vibrations.
// also, the other side should be somehow fixed to the tray, either by drilling
// an extra hole and fixing it there or with sticky tape.


module adapter() {
	adapterwidth = 32;
	holes_25 = [13+1.25, 90.2+1.25];
	holes_35 = [27+1.25, 69+1.25, 128+1.25];

	difference() {
		hull() {
			// Size of the full bild
			cube([0.001, 100, 6.5]);

			translate([adapterwidth-8, 0, 0])
			cube([8, 140, 10]);
		}
		hull() {
			pos = [[5,90,0],[5,95,0],[27,90,0],[27,130,0]];

			for (i = [0:1:3]) {
				translate([0,0,-0.01])
				translate(pos[i])
				cylinder(d=5, h=15, $fn=50);
			}
		}
		hull() {
			pos = [[5,7,0],[5,40,0],[27,7,0],[27,40,0]];

			for (i = [0:1:3]) {
				translate([0,0,-0.01])
				translate(pos[i])
				cylinder(d=5, h=15, $fn=50);
			}
		}
		hull() {
			pos = [[5,47,0],[5,83,0],[27,47,0],[27,83,0]];

			for (i = [0:1:3]) {
				translate([0,0,-0.01])
				translate(pos[i])
				cylinder(d=5, h=15, $fn=50);
			}
		}

		for (pos = holes_25) {
			// 2.5/2 + 1.88
			translate([0, pos, 1.88+1.25])
			rotate([0, 90, 0])
			cylinder(d=3.5, h=8, $fn=7);

			translate([adapterwidth-10, pos, 1.88+1.25])
			hull() {
				rotate([0, 90, 0])
				cylinder(d=6, h=12, $fn=7);

				rotate([0, 90, 0])
				translate([10,0,0])
				cylinder(d=6, h=12, $fn=7);
			}

		}
		for (pos = holes_35) {
			translate([adapterwidth-10, pos, 5+1.25])
			rotate([0, 90, 0])
			cylinder(d=3, h=11, $fn=7);
		}
	}
}

adapter();
