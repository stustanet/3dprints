$fn = 20;

width=50;
length=100;

outerwall=10;

screw_front_lenght=13;
screw_head_length = 3.5;
screw_head_diameter=7.8;
screw_inner_diameter=3;
screw_thread_diameter=4.1;
screw_thread_depth = 0.4;
paddle_corner_radius=10;

springhole_diameter = 15;

pressblob_diameter=10;

sidemount_width=17;

mount_angle = 19.0;
/*
  TODO proper wire management
*/

module paddle_top() {
	difference() {
		hull() {
			translate([paddle_corner_radius, length-paddle_corner_radius])
			cylinder(r=paddle_corner_radius, h=outerwall);

			translate([width-paddle_corner_radius, length-paddle_corner_radius])
			cylinder(r=paddle_corner_radius, h=outerwall);

			translate([0,outerwall/2,outerwall/2])
			rotate([0,90,0])
			cylinder(d=outerwall, h=width);
		}
		// Screw hole
		translate([-1, outerwall/2, outerwall/2])
		rotate([0, 90, 0]) {
			cylinder(h=width+2, d=screw_thread_diameter);
			translate([0, 0, 1])
			#cylinder(d1=screw_head_diameter, d2=screw_thread_diameter, h=screw_head_length);
			translate([0, 0, width-screw_head_length+1])
			#cylinder(d1=screw_thread_diameter, d2=screw_head_diameter, h=screw_head_length);
		}


		// cubic hole
		translate([screw_front_lenght,-1,0]) {
		cube([width-screw_front_lenght*2,outerwall+3, outerwall+1]);

		// Diagonal spacing
		translate([0,0,-4])
		rotate([-13,0,0])
		cube([width-screw_front_lenght*2,outerwall*10, outerwall]);
		}

		// Springhole
		translate([width/2, length/2])
		cylinder(d=springhole_diameter, h=outerwall/2, center=true);

	}

	// pressblob
	hull(){
		translate([width/2,length*0.83, 0]) {
			translate([0,0,pressblob_diameter/2])
			cylinder(d=pressblob_diameter, h=0.1, center=true);
			rotate([0,90,0])
			cylinder(d=pressblob_diameter, h=pressblob_diameter, center=true);
		}
	}

}

module taster() {
	translate([-3.2, -4.3, -16]){
		cube([6.4,13.1,12]);
	}
	translate([0,0,-4]) {
		cylinder(d=6.3,h=4);
		cylinder(d=2.4, h=6.6);
	}

	translate([0,0,-12]) {
		translate([0,-2.8,-5])
		cube([3,3,3], center=true);
		translate([0,2.5,-5])
		cube([3,3,3], center=true);
		translate([0,7.3,-5])
		cube([3,3,3], center=true);
	}
}

module paddle_base() {
	difference () { union() {
		difference() {
			translate([screw_front_lenght,0,0]) {

				translate([0, outerwall/2, outerwall/2])
				rotate([0, 90, 0])
				cylinder(d=outerwall, h=width-screw_front_lenght*2-1);

				//cube([width-screw_front_lenght*2-1, outerwall, outerwall]);
				hull() {
					cube([width-screw_front_lenght*2-1,outerwall, outerwall/2]);
					translate([(width-screw_front_lenght*2)/2,length*4/5,0])
					cylinder(d=20,h=outerwall);
				}
			}
			// Screw hole
			translate([-1, outerwall/2, outerwall/2])
			rotate([0, 90, 0])
			cylinder(h=width+2, d=screw_thread_diameter);

			// springhole
			translate([width/2, length/2, outerwall-1])
			cylinder(d=springhole_diameter, h=outerwall/2, center=true);
		}

		difference() {
		// support max depth
			union() {
				translate([(width-screw_front_lenght*2)/2 - 4,length*4/5 -5,0]) {
					cube([10, 10, 35]);
				}
				translate([(width-screw_front_lenght*2)/2 + 19,length*4/5 -5,0]) {
					cube([10, 10, 35]);
				}
			}

			translate([-0.5,2,-1.5])
			rotate([down,0,0])
			cube([width, length, outerwall * 2]);
		}


		//diagonal holding stuff
		translate([-sidemount_width-1, 0, 0]) {
			rotate([mount_angle,0,0]) {
				translate([0,20,-2])
				cube([sidemount_width-1, length-24.7, outerwall]);

				translate([width+sidemount_width+2,20,-2])
				cube([sidemount_width-1, length-24.7, outerwall]);
			}
			translate([0,16.2,0]) {
				cube([sidemount_width-1, 10, 14.0]);
				cube([width + sidemount_width * 2, 10, 2]);
			}

			translate([width+sidemount_width+2,16.2,0]) {
				cube([sidemount_width-1, 10, 14.0]);
			}
			//support diagonal
			translate([0, length-20, 0]) {
				// side A
				cube([width+sidemount_width*2, 10, outerwall]);
				translate([0, 0, 0])
				cube([sidemount_width-1, 10, 29]);
				translate([width+sidemount_width+2, 0, 0])
				cube([sidemount_width-1, 10, 29]);
			}
		}
	}

	// Taster hole

		// Wireing
		translate([width/2,length*4/5, 0]) {
			translate([0, 0, 20]) {
				rotate([0,0,180])
				#taster();
			}
			translate([0,-2,1])
			cube([10,16,3], center=true);

			translate([0, 10, 1])
			cube([2,30,3], center=true);

			translate([0, -8, 1])
			cube([30,4,3], center=true);
		}
	}
}

up = 20.5;
down=19;

translate([-0.5,2,-1.5])
rotate([down,0,0])
color([0,1,0])
paddle_top();
!paddle_base();
