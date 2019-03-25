$fn=200;
diameter = 65;
bottom_width = 30;
bottom_length = 25;
height=20;
wall_width = 2;

wall_scale_factor = 1-(wall_width*2)/diameter;
echo("Wall scale factor: ", wall_scale_factor);

module raw() {
intersection() {
    cylinder(d=diameter, h=height, center=true);
//    translate([-diameter/2, -14, 0])
//    cube([diameter, diameter, height]);
}

deg = 66;

translate([0, -13, 0])
translate([0,0,-height/2])
linear_extrude(height=height, convexity=10) {
polygon([[-diameter * sin(deg)/2, 0],
           [-bottom_width/2, -bottom_length],
           [bottom_width/2, -bottom_length],
           [diameter * sin(deg)/2, 0]]);
}
}

module lcd() {
    cube([28,28,2], center=true);
    translate([0,2,-1])
    cube([28,15,2], center=true);
}

difference() {
    raw();
    translate([0,0,wall_width])
    scale([wall_scale_factor, wall_scale_factor, 1])
    raw();
    
    translate([0, 10, -6])
    #lcd();
}
