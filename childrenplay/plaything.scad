h=5;

module triangle() {
    cylinder(d=8, $fn=3, h=h, center=true);
}

module thing(fn) {
    cylinder(d=7.5, $fn=fn, h=h, center=true);
}


module roundthing() {
    cylinder(d=7, $fn=100, h=h, center=true);
}

module cubething() {
    cube([6,6,h], center=true);
}

scale([7.5, 7.5, 3]) {
difference() {
    cube([20, 20, 2.3], center=true);
    
    translate([-8.5, -8.5, 0])
    cylinder(d=0.5, h=3, $fn=20, center=true);
    
    translate([-5, 5, 0])
    thing(5);
    
    translate([-5, -5, 0])
    triangle();
    
    translate([5, 5, 0])
    roundthing();
    
    translate([5, -5, 0])
    cubething();
}

translate([20, 0, 0])
rotate([0, 0, 270]) {
    translate([-5, 5, 0])
    thing(5);
    
    translate([-5, -5, 0])
    triangle();
    
    translate([5, 5, 0])
    roundthing();
    
    translate([5, -5, 0])
    cubething();
}
}