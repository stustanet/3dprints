use<ssn/ziptie_flansch.scad>

module pcb() {
	// PCB
	hull() {
		cube([51, 51, 2], center=true);
		translate ([0,0,4]) cube([51, 51-8, 2], center=true);
		
	}

	// underbelly
	translate ([0,-1,-2]) cube([51, 51- 2 - 4, 5], center=true);

	// upper mount: plugs
	translate ([0, 19, 1 + 9/2]) cube([51, 5, 9], center=true);

	// upper mount: rest
	translate([0,-(51-40)/2+2, 6]) cube([51, 40, 10], center=true);

	translate([6, -3, 0]) cylinder(d=8, h=20, $fn=8);
}

module mount() {
	difference () {
		translate([1, 0, -1]) cube([53, 55, 11], center=true);
		pcb();
	}
	translate([1, 51/2-0.5, 8]) hull () {

		translate([0,-0.2,-3.5])
		cube([53, 5.4, 0.1], center=true);

		translate([0,1.5,4])
		cube([53, 2, 0.1], center=true);
	}

	for (i = [0:3]) {
		translate([51/2 - 7 - 51/4 * i, 51/2+1, 12]) {
			rotate([0,0,0])
			ziptie_flansch(0);
		}
	}

	translate([51/2-7, -51/2-1, 4])
	ziptie_flansch(0);


}


mount();
%pcb();
