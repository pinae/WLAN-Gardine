module rope_wheel() {
    rope_d = 2;
    wheel_d = 25;
    difference() {
        translate([0, 0, -3.5]) cylinder(d=wheel_d+4, h=15, $fn=64);
        for(a=[0:90]) {
            hull() {
                rotate([0, 0, 4*a]) translate([wheel_d/2, 0, 1*sin(a*4*8)]) sphere(d=rope_d-0.3, $fn=16);
                rotate([0, 0, 4*(a+1)]) translate([wheel_d/2, 0, 1*sin((a+1)*4*8)]) sphere(d=rope_d-0.3, $fn=16);
                rotate([0, 0, 4*a]) translate([wheel_d/2+5, 0, 1*sin(a*4*8)]) sphere(d=rope_d+2, $fn=16);
                rotate([0, 0, 4*(a+1)]) translate([wheel_d/2+5, 0, 1*sin((a+1)*4*8)]) sphere(d=rope_d+2, $fn=16);
            }
        }
        translate([0, 0, -4]) cylinder(d=5.2, h=20, $fn=32);
        translate([4, 0, 7]) rotate([0, 90, 0]) cylinder(d=6.3, h=2.6, $fn=6);
        translate([4, -5.6/2, 7+1.5]) cube([2.6, 5.6, 10]);
        translate([0, 0, 7]) rotate([0, 90, 0]) cylinder(d=3.2, h=30, $fn=32);
        translate([10, 0, 7]) rotate([0, 90, 0]) cylinder(d=6.3, h=30, $fn=32);
    }
}

module rope_wheel_print_support() {
    rope_d = 2;
    wheel_d = 26;
    union() {
        for(a=[0:90]) {
            hull() {
                rotate([0, 0, 4*a]) translate([wheel_d/2, 0, 1*sin(a*4*8)]) sphere(d=rope_d-0.9, $fn=16);
                rotate([0, 0, 4*(a+1)]) translate([wheel_d/2, 0, 1*sin((a+1)*4*8)]) sphere(d=rope_d-0.9, $fn=16);
                rotate([0, 0, 4*a]) translate([wheel_d/2+5, 0, 1*sin(a*4*8)]) sphere(d=rope_d+1.4, $fn=16);
                rotate([0, 0, 4*(a+1)]) translate([wheel_d/2+5, 0, 1*sin((a+1)*4*8)]) sphere(d=rope_d+1.4, $fn=16);
            }
        }
        difference() {
            translate([0, 0, -3.5]) cylinder(d=wheel_d+12, h=8, $fn=64);
            translate([0, 0, -4]) cylinder(d=wheel_d+5, h=20, $fn=64);
            translate([0, 0, -4/2]) cube([1, wheel_d+15, 20], center=true);
            translate([0, 0, -4/2]) cube([wheel_d+15, 1, 20], center=true);
        }
    }
}

rope_wheel();
rope_wheel_print_support();