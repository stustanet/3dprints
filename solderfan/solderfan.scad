$fn=30;
fan_height = 109;
fan_angle = 30;
mount_length = 20;
foot_height = 100;

// Fan parameters
fan_plate_height = 4.2;
filter_width = 127;
fan_width = 120;
fanfilter_overlap = (filter_width - fan_width) / 2;
hole_diameter = 4;
hole_distance = 109 - hole_diameter;

// Modelling the original part

// front and back of the fan (used internally by module fan)
module fan_baseplate() {
	difference() {
		cube([fan_width, fan_width,fan_plate_height], center=true);
		for (i=[[1,1],[-1,1],[-1,-1],[1,-1]]) {
			translate([hole_distance/2*i[0], 
			           hole_distance/2*i[1], 0])
			cylinder(d=hole_diameter, h=fan_plate_height,center=true);
		}
	}
}

// the fan that should be positioned
// Any Standard 120mm fan will do
module fan() {
	translate([0,0,fan_plate_height/2])
	fan_baseplate();
	translate([0,0,(16.7)/2+fan_plate_height]){
		intersection() {
			cube([fan_width, fan_width,16.7 ], center=true);
			cylinder(d=119, h=16.7,center=true);
		}
	}
	translate([0,0,16.7 + fan_plate_height*1.5])
	fan_baseplate();
}

// Filter modell:  PKM CO2 Kassettenkohlefilter Umluftbetrieb Kohlefilter Aktivkohle
module approxfilter() {
	h=9.8;
	translate([0,0,-h]) {
		intersection(){
			overlap = 29;
			translate([0, 14.5,0])
			cube([127,62+overlap, h*2],center=true);
			translate([0,-3.5,0])
			cylinder(r=70, h=h, $fn=100);
		}
		translate([0,10,0])
		rotate([0,0,180])
		intersection() {
			overlap=33;
			translate([0,overlap,0])
			cube([127,20+overlap*2, h*2],center=true);
			cylinder(r=77, h=h, $fn=100);
		}
		translate([-67, 0, h/2])
		cube([9, 35, h], center=true);
		translate([67, 0, h/2])
		cube([9, 35, h], center=true);
	}
}

module lamp() {
	// PCB
	cube([20, 100, 2], center=true);
	// Cooler (measurements are estimated
	translate([0, 0, 27/2]) cube([10, 80, 25], center=true);
}



// Here begins the real design


// One of the foots where the fan is going to be connected to
module foot() {
	height = foot_height;
	thickness = [12, 7];
	regulator_hole_diameter = 2.6;
	mount_hole_diameter = 4;
	length = tan(fan_angle) * (fan_height + mount_length);

	difference() {
		cube([thickness[0], thickness[1], height]);
		rotate([0, -90, 0])
		translate([thickness[0] + 10,
		           thickness[1]/2,
		           -thickness[0]]) {
			cylinder(d=regulator_hole_diameter,
			         h=thickness[0]-2);
			translate ([26,0,0])
			cylinder(d=regulator_hole_diameter,
			         h=thickness[0]-2);
		}
	}

	difference() {
		cube([length, thickness[1], thickness[0]]);
		translate([length/2, -1, thickness[0]/2])

		// The Connector placeholder
		cube([thickness[0], thickness[1]+2, thickness[0]]);
	}

	difference() {
		hull() {
			translate([thickness[0]-5, 0, height]) {
				rotate([0, fan_angle, 0])
				cube([5, thickness[1], mount_length]);
			}
			translate([thickness[0]/2, thickness[1]/2, height]) {
				cube([thickness[0], thickness[1], 1], center=true);
			}
		}
		translate([thickness[0]-5, thickness[1]/2, height + mount_length-4]) {
			rotate([0, 90 + fan_angle, 0])
			cylinder(h=30, d=mount_hole_diameter, $fn=30);
		}
	}
}

module connector() {
	thickness = 12;
	overhang = 3;
	width = 98;
	foot_thickness = [12, 7];

	difference() {
		cube([thickness,
		      width + foot_thickness[1] * 2 + overhang * 2,
		      thickness]);

		translate([-1, overhang, -thickness/2])
		cube([thickness+2, foot_thickness[1], thickness]);

		translate([-1, 
		           overhang + foot_thickness [1]+ width, 
		           -thickness/2])
		cube([thickness+2, foot_thickness[1], thickness]);
		translate([0, overhang * 2 + foot_thickness[1], foot_thickness[1]])
		cube([thickness, width - overhang * 2, 10]);
	}
}

module clamp() {
	difference() {
		translate([fan_width/2-9, 0, -7])
		cube([15, fan_width , 12], center=true);

		fan();
		approxfilter();
		translate([fan_width/2-9, hole_distance/2, -5]) {
			cylinder(d=hole_diameter, h=30,center=true);
		}

		translate([fan_width/2-9, -hole_distance/2, -5]) {
			cylinder(d=hole_diameter, h=30,center=true);
		}
	}
}

module lamp_holder() {
	translate([0, -120/2, -3])
	difference () {
		hull() {
			translate([5, 0, 25]) {
			translate([-1.7, 60, -1.9]) rotate([90, 0, 0]) cylinder(d=5, h=120, center=true);
			rotate([0, 90-fan_angle, 0]) {
				cube([30, 120, 0.1]);
			}
			}
			translate([-15, 0, -3])
			cube([35, 120, 2]);
		}
		translate([-12, 3, 6]) cube([35, 120 - 6, 30]);

		translate([0, 12, -5]) cube([25, 96, 10]);

		// Rail
		translate([-10, 11, 1.99]) cube([35, 98, 30]);
		hull () {
			translate([-10, 9.5, 1.99]) cube([35, 101, 2]);
			translate([-10, 11, 4]) cube([35, 98, 2]);
		}

		// Light opening
		translate([-10, 12, 1.9]) hull () {
			cube([20, 96, 0.1]);
			translate([-5, 0, -5])
			cube([30, 96, 0.1]);
		}

		/* // Holes for wires
		translate([0, 7, -5]) {
			cylinder(d=3, h=20);
			translate([0, 5, 2])
			rotate([0, 45, 0])
			cube([5, 10, 5], center=true);
		}
		translate([0, 120 - 7, -5]) {
			cylinder(d=3, h=20);
			translate([0, -5, 2])
			rotate([0, 45, 0])
			cube([5, 10, 5], center=true);
		}
		*/

		// holes for zip ties to mount
		translate([3, 60, 21]) {
			rotate([90, 0, 0]) cylinder(d=4, h=200, center=true, $fn=6);
		}
	}
}

// The original part for reference
%translate([tan(fan_angle) * (fan_height + mount_length)/2 + 11,
            fan_width/2-4,
            foot_height + 120/2 - 7])
rotate([0, - 90 + fan_angle, 0]) {
	fan();
	translate([0, 0, 35]) approxfilter();
 }

// Print one of each

// The stand
translate([0, 0,   0]) foot();
translate([0, 105, 0]) foot();
translate([tan(fan_angle) * (fan_height + mount_length)/2, -3, 0]) connector();

// Everything here is relative to the fan position
translate([tan(fan_angle) * (fan_height + mount_length)/2 + 11,
           fan_width/2-4,
           foot_height + 120/2 - 7])
rotate([0, - 90 + fan_angle, 0]) {
	translate([0,0,25]) rotate([0, 180, 90]) clamp();
	translate([0,0,25]) rotate([0, 180, -90]) clamp();

	translate([120/2 - 15, 0, -15])
	rotate([0, 90 - fan_angle, 0]) 
		rotate([0, 0, 180]) {
		%lamp();
		lamp_holder();
	}
}
