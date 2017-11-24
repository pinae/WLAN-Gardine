seildurchmesser = 2;

module umlenkrolle() {
    difference() {
        union() {
            cylinder(d=26, h=8.5, $fn=64);
            cylinder(d=30, h=8.5/2-seildurchmesser+sqrt(seildurchmesser*seildurchmesser/2)-2, $fn=64);
            translate([0, 0, 8.5/2-seildurchmesser+sqrt(seildurchmesser*seildurchmesser/2)-2]) cylinder(d1=30, d2=26, h=2, $fn=64);
            translate([0, 0, 8.5/2+seildurchmesser-sqrt(seildurchmesser*seildurchmesser/2)]) cylinder(d1=26, d2=30, h=2, $fn=64);
            translate([0, 0, (8.5/2+seildurchmesser-sqrt(seildurchmesser*seildurchmesser/2)+2)]) cylinder(d=30, h=8.5-(8.5/2+seildurchmesser-sqrt(seildurchmesser*seildurchmesser/2)+2), $fn=64);
        }
        translate([0, 0, -1]) cylinder(d=20, h=12, $fn=64);
        translate([0, 0, 0.5]) cylinder(d=22.2, h=10, $fn=64);
        translate([0, 0, 8.5/2]) rotate_extrude(angle=360, convexity=2, $fn=64) { 
            translate([26/2+seildurchmesser-sqrt(seildurchmesser*seildurchmesser/2), 0, 0]) circle(d=seildurchmesser, $fn=32);
        }
    }
}

umlenkrolle();