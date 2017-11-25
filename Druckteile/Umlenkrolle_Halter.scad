module umlenrolle_halter() {
    difference() {
        union() {
            cylinder(d=7.8, h=7, $fn=48);
            translate([0, 0, 7]) cylinder(d=10, h=8, $fn=48);
            translate([-25, 0, 18.5]) rotate([0, 90, 0]) cylinder(d=20, h=50, $fn=48);
            for(i=[-1, 1]) for(j=[-1, 1]) {
                translate([i*22, j*10, 11]) cylinder(d=10, h=10, $fn=6);
            }
        }
        translate([0, 0, -1]) cylinder(d=4.3, h=50, $fn=32);
        translate([0, 0, 10]) cylinder(d=8, h=5, $fn=6);
        translate([-26, 0, 18.5]) rotate([0, 90, 0]) cylinder(d=10, h=52, $fn=48);
        translate([-30, -30, 18.5]) cube([60, 60, 60]);
        for(i=[-1, 1]) for(j=[-1, 1]) {
            translate([i*22, j*10, 10]) cylinder(d=4.3, h=12, $fn=32);
            translate([i*22, j*10, 10]) cylinder(d=8, h=4, $fn=6);
        }
    }
}

module umlenrolle_gegenstueck() {
    difference() {
        union() {
            for(i=[0:12]) rotate([0, 0, i*360/12]) translate([8, 0, 0]) cylinder(d=3, h=5, $fn=32);
            cylinder(d=16, h=5, $fn=12);
            cylinder(d=10, h=7, $fn=48);
        }
        translate([0, 0, -1]) {
            cylinder(d=4.3, h=50, $fn=32);
            cylinder(d=8, h=4, $fn=6);
        }
    }
}

module umlenrolle_klemme() {
    difference() {
        union() {
            translate([-25, 0, 0]) rotate([0, 90, 0]) cylinder(d=20, h=50, $fn=48);
            for(i=[-1, 1]) for(j=[-1, 1]) {
                translate([i*22, j*10, 0]) cylinder(d=10, h=8, $fn=6);
            }
        }
        translate([-26, 0, 0]) rotate([0, 90, 0]) cylinder(d=10, h=52, $fn=48);
        translate([-30, -30, -60]) cube([60, 60, 60]);
        for(i=[-1, 1]) for(j=[-1, 1]) {
            translate([i*22, j*10, -1]) cylinder(d=4.3, h=12, $fn=32);
        }
    }
}

/*umlenrolle_halter();
translate([0, 0, -7]) umlenrolle_gegenstueck();
translate([0, 0, 18.5]) umlenrolle_klemme();*/

translate([0, -21, 0]) umlenrolle_gegenstueck();
translate([0, 0, 18.5]) rotate([180, 0, 0]) umlenrolle_halter();
translate([0, 30, 0]) umlenrolle_klemme();