seildurchmesser = 3;

module ringzieher(muttertasche=true) {
    difference() {
        union() {
            cylinder(d=40, h=7, $fn=64);
            for(i=[-1, 1]) {
                translate([0, 0, 2.5]) rotate([0, 0, i*45]) cube([50, 10, 5], center=true);
            }
        }
        translate([14, 0, -1]) cylinder(d=12, h=9, $fn=32);
        translate([20, 0, 3.5]) cube([12, 12, 9], center=true);
        for(i=[-1, 1]) {
            translate([0, i*(26/2+seildurchmesser-sqrt(seildurchmesser*seildurchmesser/2)), -1]) cylinder(d=seildurchmesser+1, h=9, $fn=32);
        }
        if(muttertasche) {
            translate([0, 0, -1]) cylinder(d=8, h=4, $fn=6);
        } else {
            translate([0, 0, -1]) cylinder(d=4.3, h=5, $fn=32);
        }
        translate([0, 0, 3.2]) cylinder(d=4.3, h=5, $fn=32);
        translate([0, 0, 7]) rotate_extrude(angle=360, convexity=2, $fn=64) { 
            translate([4/2+seildurchmesser/2+0.4, 0, 0]) circle(d=seildurchmesser-0.5, $fn=32);
        }
        for(i=[-1, 1]) {
            for(j=[-1, 1]) {
                translate([i*j*seildurchmesser/4, i*(26/2+seildurchmesser-sqrt(seildurchmesser*seildurchmesser/2)), 7]) rotate([90, 0, 90-i*90+j*asin((4/2+seildurchmesser/2+0.4-seildurchmesser/4)/14)]) cylinder(d=seildurchmesser-0.5, h=34, $fn=32);
            }
        }
        //cube([100, 100, 100]);
    }
}

ringzieher();
translate([45, 0, 0]) mirror([0, 1, 0]) ringzieher(false);