$fn=100 * 1;

// thickness of the axle
axle_diameter = 15; // [5:20]

// thickness of the rod to mount the axle on
pin_diameter = 5.5; // [1:15]

// length of the axle
pin_length = 10;

// width of the axle holder
plate_overhead = 5;

// height of the axle holder
plate_length = 3;

// length of the spared out part at the end of the axle
tilt_fix_length = 5;

module axle() {
	difference () {
        union() {
            translate([0,0,-tilt_fix_length])
            cylinder(d=axle_diameter, h=pin_length + tilt_fix_length);

            translate([0,0,pin_length])
            cylinder(d1=axle_diameter + plate_overhead/2, d2=axle_diameter + plate_overhead, h=plate_length);

            translate([0,0,-plate_length])
            cylinder(d=axle_diameter, h=plate_length);
        }
        // Introduced a fix that the wheel will not tilt
        translate([-axle_diameter/2, 0, -tilt_fix_length-1])
        cube([axle_diameter, axle_diameter/2, tilt_fix_length+1]);

        #translate([0,0,-tilt_fix_length-1])
        cylinder(d=pin_diameter, h=pin_length + plate_length*2 + tilt_fix_length);

        translate([0,50,0])
        cube ([1,100,100], center=true);
	}

}

module wheel() {
	difference() {
		union() {
			cylinder(d=37, h=5);
			translate([0,0,5])
			cylinder(d1=31, d2=27, h=2);
			translate([0,0,5])
			cylinder(d=27, h=10);
		}
		translate([0,0,-1])
		cylinder(d=axle_diameter*1.09, h=200);

		translate([0,0,12])
		scale([1.09, 1.09, 1.09])
		cylinder(d1=axle_diameter + plate_overhead/2, d2=axle_diameter + plate_overhead, h=plate_length);
	}
}

wheel();
translate([0,0,2])
axle();
