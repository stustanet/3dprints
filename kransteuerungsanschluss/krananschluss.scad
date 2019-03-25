module roundplate() {
    difference () {
        union() {
            // upper round
            cylinder(d=23, h=1);
            // lower round
            translate([0,0,1])
            cylinder(d=18, h=1);
        }
        // hole for plug
        cylinder(d=16, h=5);
    }
}

module cornerplate() {
    difference () {
        cube([40, 30, 1.5]);
        translate([20, 13, -1]) 
        cylinder(d=16, h=10);
    }
}

cornerplate();
//roundplate();