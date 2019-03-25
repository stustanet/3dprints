width=1.5;
height=20;
resetd=2;
reseth=3.3;

$fn=100;
scale([13/17, 1, 1])
difference() {
	union () {
		cylinder(d1=18+width*2, d2=18, h=height + width-3);
		translate([0,0,height + width-3])
		cylinder(d1=18, d2=resetd, h=3);
	}
	cylinder(d1=18, d2=18-width*2, h=height-5);
	translate([0,0,height-5])
	cylinder(d1=18, d2=3, h=5);
}

translate([0,0,height+width]) {
	cylinder(d=resetd, h=reseth);
}
