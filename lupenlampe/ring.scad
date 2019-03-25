d=87;
h=2.4;

$fn=100;

pincnt=8;
pinangles = [0:360/pincnt:360];
pinangle_increment = 28/(d*3.1415) * 360;
offset = 41;
holeangles = [ offset:360/4:360+offset ];

difference () {
	cylinder(d=d+6, h=h);

	translate([0,0,-.1])
	cylinder(d=d-8, h=h+.2);

	for ( i = pinangles ) {
		rotate([0,0,i])
		translate([d/2,0,-.1])
		cylinder(d=1, h=h+.2);

		rotate([0,0,i+pinangle_increment])
		translate([d/2,0,-.1])
		cylinder(d=1, h=h+.2);
	}
	for ( i = holeangles ) {
		rotate([0,0,i])
		translate([(d-1)/2,0,-.1])
		cylinder(d=2.5, h=h+.2);
	}
}
