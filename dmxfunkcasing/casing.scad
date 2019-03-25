platine_width = 15;
platine_length = 32;
platine_height = 12;
wall_width = 2;
$fn = 100;

module platine() {
    // Main board
    cube([platine_width, platine_length, platine_height]);
    
    translate([platine_width/2, 0, platine_height/2])
    rotate([90,0,0])
    cylinder(h=10, d=4);

    translate([platine_width/2, 25, platine_height/2])
    rotate([-90,0,0])
    cylinder(h=25, d=2);

}

module deckel() {
    difference() {
        translate([wall_width, wall_width, wall_width*2])
        cube([platine_width + wall_width*2, platine_height + wall_width*2, platine_length + wall_width]);
        
        translate([wall_width*2, platine_height + wall_width*2, wall_width*2])
        rotate([90, 0, 0])
        platine();

    }
}

module base() {
    difference () {
        cube ([platine_width + wall_width * 4,
               platine_height + wall_width * 4,
               wall_width * 3]);
        translate([wall_width, wall_width, wall_width])
        cube ([platine_width + wall_width * 2,
               platine_height + wall_width * 2,
               wall_width * 2]);
        translate([wall_width*2, platine_height + wall_width*2, wall_width*2])
        rotate([90, 0, 0])
        platine();
    }
}

!base();
deckel();
//translate([wall_width*2, platine_height + wall_width*2, wall_width*2])
//rotate([90, 0, 0])
//platine();