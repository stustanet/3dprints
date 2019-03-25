$fn=200;

inner_diameter = 89.5;
fix_radius = inner_diameter/2 + 2.7;

pincnt = 8;
pinangles = [0:360/pincnt:360];
pinangle_increment = 28/(fix_radius*2*3.1415) * 360;
offset = 41;

h=1.2;

difference() {
	cylinder(d=103, h=h);
	translate([0,0,-0.1])
	cylinder(d=89.5, h=h+.2);

	for (i = [0, 90, 180, 270]) {
		rotate([0,0,i])
		translate([fix_radius, 0, -0.1])
		cylinder(d=2.1, h=h+.2);
	}

	off = 5.5;
	for ( i = pinangles ) {
		rotate([0,0,i+off])
		translate([fix_radius, 0, -0.1])
		cylinder(d=1.2, h=h+.2);

		echo(pinangle_increment);
		rotate([0,0,i + pinangle_increment + off ])
		translate([fix_radius, 0, -0.1])
		cylinder(d=1.2, h=h+.2);
	}

}
