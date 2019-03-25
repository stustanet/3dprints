
difference() {
union() {
translate([0,-1,0])
cube([38, 30, 2], center=true);
translate([0,1,1.5])
cube([34, 30, 1], center=true);
translate([0,0,2.75])
cube([34, 28, 1.5], center=true);
}

cylinder(d=25, h=30, center=true, $fn=80);
}