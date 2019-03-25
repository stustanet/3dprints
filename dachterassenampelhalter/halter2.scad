$fn=100;

module lcd() {
    cube([28,28,2], center=true);
    translate([0,0,-2])
    cube([28,20,2], center=true);
}

module cube_or_sphere(cubes, d3, d) {
    if (cubes) {
        if (d3) {
            cube([d,d,d], center=true);
        } else {
            square([d,d], center=true);
        }
    } else {
        if (d3) {
            sphere(d=d, $fn=16);
        } else {
            circle(d=d, $fn=16);
        }
    }
}


module outer(cubes=false) {
    hull() {
        rotate_extrude() {
            translate([35, 0]) {
                translate([0, 10])
                cube_or_sphere(cubes, false, 5);
                translate([0, -9])
                cube_or_sphere(cubes, false, 5);
            }
        }

        bottom_offset = 40;
        bottom_width = 30;
        translate([0, -bottom_offset, 10.19]) {
            translate([-bottom_width/2, 0, 0])
            cube_or_sphere(cubes, true, 5);
            translate([bottom_width/2, 0, 0])
            cube_or_sphere(cubes, true, 5);
        }
        translate([0, -bottom_offset, -9.0]) {
            translate([-bottom_width/2, 0, 0])
            cube_or_sphere(cubes, true, 5);
            translate([bottom_width/2, 0, 0])
            cube_or_sphere(cubes, true, 5);
        }
    }
}

module upper(cubes=false) {
    difference() {
        intersection() {
            outer(cubes);
            translate([0,0,-5])
            cube([90, 90, 30], center=true);
        }
        // create holders for buttons
        /*union() {
            //left
            translate([-35, 15, -20])
            difference() {
                cube([20, 20, 30]);
                rotate([0,0,45])
                translate([15,-22,15])
                cube([20, 20, 30], center=true);
            }

            //right
            translate([15, 15, -20])
            difference() {
                cube([20, 20, 30]);
                rotate([0,0,45])
                translate([-7.5,7.5,15])
                cube([20, 20, 30], center=true);
            }
        }*/
    }
}

module under() {
    difference () {
        union () {
            intersection() {
                outer(false);
                translate([0,0,25])
                cube([90, 90, 30], center=true);
            }

            intersection () {
                translate([0, 0, 8.5])
                cube([90, 90, 3], center=true);
                translate([0,0,2])
                scale([0.93,0.93,1])
                upper(true);
            }
        }

        translate([0,0,1])
        scale([0.89,0.89,1])
        upper(true);
        
        // create holders for buttons
        //left
        translate([-35, 15, -20])
        rotate([0,0,45])
        translate([15,-2.5,25.5])
        cube([6.5, 12, 10], center=true);
        //right
        translate([35, 15, -20])
        rotate([0,0,-45])
        translate([-15,-2.5,25.5])
        cube([6.5, 12, 10], center=true);

    }
}

module button() {
    translate ([-3.24, -10]) {
        // Main cube
        cube([6.5, 10, 20]);
        // Button itself
        translate([0,9,8])
        cube([6.5, 10, 12]);
        // Holders in the back
        translate([(6.5-3)/2, -4, 0])
        cube([3, 4, 20]);
        
    }
    hull() {
        translate([3.5, -7, 0])
        cylinder(d=3, h=20);
        translate([-3.5, -7, 0])
        cylinder(d=3, h=20);
    }

}

module reset_button_hole() {
    rotate([-90, 0, 0])
    cylinder(d=2, h=5);
}

module reset_button_holder() {
    
}

module battery() {
    cube([26, 51, 13], center=true);
}


module main_casing_bottom() {
    difference () {
        union() {
            // Create core frame
            difference() {
                upper(false);
                translate([0,0,2])
                scale([0.93,0.93,1])
                upper(true);
            }

            // create holders for buttons
            intersection() {
                union() {
                    //left
                    translate([-35, 15, -20])
                    difference() {
                        cube([20, 20, 30]);
                        rotate([0,0,45])
                        translate([15,-22,15])
                        cube([20, 20, 30], center=true);
                    }

                    //right
                    translate([15, 15, -20])
                    difference() {
                        cube([20, 20, 30]);
                        rotate([0,0,45])
                        translate([-7.5,7.5,15])
                        cube([20, 20, 30], center=true);
                    }
                }
                // Limit the holders to the casing
                upper(false);
            }
        }
        // Remove the lcd
        translate([0,13,-9])
        lcd();

        // Remove the button left
        rotate([0, 0, 45])
        translate([0, 36.5, -9.5])
        button();

        // Remove the button right
        rotate([0, 0, -45])
        translate([0, 36.5, -9.5])
        button();

        translate([0, 33, -6.5])
        reset_button_hole();
    }
}

//rotate([180, 0, 0])
//under();
main_casing_bottom();

//button();

//%translate([0, -14, 0])
//battery();