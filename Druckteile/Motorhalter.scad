module motorhalter() {
    difference() {
        union() {
            translate([-25, -25, 0]) cube([50, 50, 7]);
            translate([-25, -25, 25]) cube([50, 50, 8]);
            for(i=[-1, 1]) {
                for(j=[-1, 1]) {
                    translate([i*20, j*20, 16]) cube([10, 10, 20], center=true);
                }
            }
        }
        translate([0, 0, -1]) cylinder(d=25, h=17, $fn=64);
        translate([0, 0, 5]) cylinder(d=34, h=20, $fn=64);
        translate([0, 0, -1]) cylinder(d=6, h=70, $fn=64);
        for(i=[-1, 1]) {
            for(j=[-1, 1]) {
                translate([i*15.5, j*15.5, -1]) cylinder(d=3.3, h=50, $fn=64);
                translate([i*15.5, j*15.5, 3]) cylinder(d=7.8, h=50, $fn=64);
            }
            translate([0, i*15, 24]) cylinder(d=8, h=4, $fn=6);
            translate([0, i*15, 24]) cylinder(d=4.2, h=40, $fn=32);
       }
       translate([-30, 0, 33]) rotate([0, 90, 0]) cylinder(d=10, h=60, $fn=32);
    }
}

module motorhalter_klemme() {
    difference() {
        translate([-25, -25, 0]) cube([50, 50, 12]);
        translate([-30, 0, 0]) rotate([0, 90, 0]) cylinder(d=10, h=60, $fn=32);
        for(i=[-1, 1]) {
            translate([0, i*15, -1]) cylinder(d=4.2, h=40, $fn=32);
        }
    }
}

//motorhalter();
//translate([0, 0, 33]) motorhalter_klemme();

translate([-40, 0, 25]) rotate([0, 90, 0]) motorhalter();
translate([20, 0, 12]) rotate([0, 180, 0]) motorhalter_klemme();