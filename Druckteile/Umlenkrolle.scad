module umlenkrolle() {
    difference() {
        union() {
            cylinder(d=26, h=8.5, $fn=64);
            cylinder(d=30, h=1.3, $fn=64);
            translate([0, 0, 1.3]) cylinder(d1=30, d2=26, h=2, $fn=64);
            translate([0, 0, 5.2]) cylinder(d1=26, d2=30, h=2, $fn=64);
            translate([0, 0, 7.2]) cylinder(d=30, h=8.5-7.2, $fn=64);
        }
        translate([0, 0, -1]) cylinder(d=20, h=12, $fn=64);
        translate([0, 0, 0.5]) cylinder(d=22.2, h=10, $fn=64);
        translate([0, 0, 4.25]) rotate_extrude(angle=360, convexity=2, $fn=64) { 
            translate([14.1, 0, 0]) circle(d=3, $fn=32);
        }
    }
}

umlenkrolle();