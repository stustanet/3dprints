$fn = 30;

function steps( start, no_steps, end) = [start:(end-start)/(no_steps-1):end];

function curve_help(r, start, end, no_steps) = [
    [for (i=steps(start, no_steps, end)) cos(i) * r], 
    [for (i=steps(start, no_steps, end)) sin(i) * r]];

function invert_mx(mx) = [ 
    for(i=[0:len(mx[0])-1]) [mx[0][i], mx[1][i] ] ];

function curve(r, start, end, no_steps=60) =
    invert_mx(curve_help(r, start, end, no_steps));

function cat(L1, L2) = [for(L=[L1, L2], a=L) a];



module approxfilter() {
    h=9.8;
    translate([0,0,-h]) {
        intersection(){
            overlap = 29;
            translate([0, 14.5,0])
            cube([127,62+overlap, h*2],center=true);
            translate([0,-3.5,0])
            cylinder(r=70, h=h, $fn=100);
        }
        translate([0,10,0])
        rotate([0,0,180])
        intersection() {
            overlap=33;
            translate([0,overlap,0])
            cube([127,20+overlap*2, h*2],center=true);
            cylinder(r=77, h=h, $fn=100);
        }
        
        translate([-67, 0, h/2])
        cube([9, 35, h], center=true);
        translate([67, 0, h/2])
        cube([9, 35, h], center=true);
        
    }
}

hole_diameter = 4;
hole_distance = 109 - hole_diameter;
outerwall = 3;


filter_width = 127;
fan_width = 120;
fanfilter_overlap = (filter_width - fan_width) / 2;

hole_outer_distance = (fan_width - hole_distance)/2;

module fan_baseplate() {
    difference() {
        cube([fan_width, fan_width,fan_plate_height], center=true);
        for (i=[[1,1],[-1,1],[-1,-1],[1,-1]]) {
                translate([hole_distance/2*i[0], 
                            hole_distance/2*i[1], 0])
            cylinder(d=hole_diameter, h=fan_plate_height,center=true);
        }
    }
}

module fan() {
    translate([0,0,fan_plate_height/2])
    fan_baseplate();
    
    translate([0,0,(16.7)/2+fan_plate_height]){
    intersection() {
        cube([fan_width, fan_width,16.7 ], center=true);
        cylinder(d=119, h=16.7,center=true);
        }
    }
    translate([0,0,16.7 + fan_plate_height*1.5])
    fan_baseplate();
}

module clamp() {
    difference() {
        translate([fan_width/2-9, 0, -7])
        cube([15, fan_width , 12], center=true);

        fan();
        approxfilter();
        
        translate([fan_width/2-9, hole_distance/2, -5]) {
        cylinder(d=hole_diameter, h=30,center=true);
        }

        translate([fan_width/2-9, -hole_distance/2, -5]) {
        cylinder(d=hole_diameter, h=30,center=true);
        }


    }
}

//color("orange")
clamp();

//color("green")
//fan();

/*
color("blue")
approxfilter();
*/
