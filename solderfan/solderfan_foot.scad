fan_height = 109;
fan_angle = 30;
mount_length = 20;
$fn=30;

module foot() {
    height = 100;
    thickness = [12, 7];
    regulator_hole_diameter = 2.6;
    mount_hole_diameter = 4;
    length = tan(fan_angle) * (fan_height + mount_length);
//    length = tan(fan_angle) * fan_height;

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
    width = fan_height;
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

// Print one of each
translate([0, 0,   0]) foot();
translate([0, 116, 0]) foot();
translate([tan(fan_angle) * (fan_height + mount_length)/2, -3, 0]) connector();

