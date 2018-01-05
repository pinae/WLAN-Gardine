module electronics_case() {
    difference() {
        translate([0, 0, 25]) cube([42+2*3, 42+2*3, 50], center=true);
        difference() {
            translate([0, 0, 50-2-5]) cube([42.3, 42.3, 10], center=true);
            difference() {
                translate([0, 0, 43]) cube([100, 100, 10], center=true);
                translate([0, 0, 35]) cylinder(d=54.1, h=20, $fn=64);
            }
        }
        difference() {
            translate([0, 0, 50-1]) cube([42.3, 42.3, 8], center=true);
            difference() {
                translate([0, 0, 49]) cube([100, 100, 8], center=true);
                translate([0, 0, 40]) cylinder(d=50.5, h=20, $fn=64);
            }
        }
        translate([-16.4/2, 20, 38]) cube([16.4, 10, 12.5]);
        difference() {
            translate([0, 0, 3+35/2]) cube([42.3, 42.3, 35.1], center=true);
            difference() {
                cube([100, 100, 80], center=true);
                cylinder(d=54.1, h=40, $fn=64);
            }
            translate([0, (42+2*3)/2-6.5, 0]) cube([9/2, 6.5, 28.91+9/2]);
            translate([-9/2-5, (42+2*3)/2-6.5, 0]) cube([10, 6.5, 28.91+9]);
        }
        for(i=[-1, 1]) {
            translate([i*14, 0, 30]) cube([0.5, 100, 50], center=true);
            translate([0, i*14, 30]) cube([100, 0.5, 50], center=true);
        }
        translate([-9/2-2, (42+2*3)/2-2.69, 28.91]) cube([11, 2.7, 9.1]); 
        translate([0, 0, 28.91+9/2]) rotate([-90, 0, 0]) cylinder(d=9, h=50, $fn=32);
        translate([0, (42+2*3)/2-6.5, 28.91+9/2]) cube([9/2, 6.5, 9/2+0.2]);
        translate([-9/2-2, (42+2*3)/2-10, 28.91]) cube([11-9/2, 10, 9.1]);
        translate([14, 22, 42]) cube([1.6, 10, 17], center=true);
        translate([-14, 22, 43]) cube([1.8, 10, 15], center=true);
    }
}

electronics_case();