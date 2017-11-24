seildurchmesser = 2;

module antriebsrolle() {
    r=26/2+0.5*seildurchmesser-sqrt(seildurchmesser*seildurchmesser/2);
    difference() {
        union() {
            cylinder(d=2*r+seildurchmesser+3, h=2, $fn=64);
            cylinder(d=2*r+seildurchmesser, h=2+0.5*seildurchmesser, $fn=64);
            cylinder(d=2*r, h=2-seildurchmesser/2+2.5*seildurchmesser+2, $fn=64);
            translate([0, 0, 2-seildurchmesser/2+2.5*seildurchmesser]) cylinder(d=2*r+seildurchmesser, h=2+0.5*seildurchmesser, $fn=64);
            translate([0, 0, 2+2.5*seildurchmesser]) cylinder(d=2*r+seildurchmesser+3, h=9, $fn=64);
        }
        translate([0, 0, 2+seildurchmesser/2]) rotate_extrude(angle=360, convexity=2, $fn=64) { 
            translate([r+seildurchmesser/2, 0, 0]) circle(d=seildurchmesser, $fn=32);
        }
        translate([0, 0, 2-seildurchmesser/2+2.5*seildurchmesser]) rotate_extrude(angle=360, convexity=2, $fn=64) { 
            translate([r+seildurchmesser/2, 0, 0]) circle(d=seildurchmesser, $fn=32);
        }
        translate([0, 0, -1]) cylinder(d=5.2, h=50, $fn=32);
        translate([4, 0, 12]) rotate([0, 90, 0]) cylinder(d=6.3, h=2.6, $fn=6);
        translate([4, -5.6/2, 12+1.5]) cube([2.6, 5.6, 10]);
        translate([0, 0, 12]) rotate([0, 90, 0]) cylinder(d=3.2, h=30, $fn=32);
        translate([0, 0, 12]) rotate([0, 90, 0]) cylinder(d=3.2, h=30, $fn=32);
    }
}
antriebsrolle();