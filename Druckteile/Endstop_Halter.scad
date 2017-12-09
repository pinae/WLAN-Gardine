 module endstop_halter() {
     difference() {
         union() {
             hull() {
                 translate([2, 10, 22]) rotate([90, 0, 0]) cylinder(d=10, h=20, $fn=64);
                 translate([2, 10, -10]) rotate([90, 0, 0]) cylinder(d=10, h=20, $fn=64);
             }
         }
         translate([-25, 0, 15]) rotate([0, 90, 0]) cylinder(d=10, h=50, $fn=64);
         translate([2, 0, 30]) cube([12, 10, 30], center=true);
         translate([0, 0, -10]) cube([30, 5.82, 12.8+20], center=true);
         translate([2, 11, 22]) rotate([90, 0, 0]) cylinder(d=4.3, h=50, $fn=64);
         translate([2, 11, -10]) rotate([90, 0, 0]) cylinder(d=4.3, h=50, $fn=64);
         translate([2, 11, 22]) rotate([90, 0, 0]) cylinder(d=8, h=4, $fn=6);
         translate([2, 11, -10]) rotate([90, 0, 0]) cylinder(d=8, h=4, $fn=6);
     }
 }
 
//translate([10, 0, 3]) rotate([0, -90, 0]) color("gray") cube([6.6, 5.82, 12.8], center=true);
translate([10, 0, 3]) rotate([0, -90, 0]) endstop_halter();
for(i=[0, 1]) for(j=[0, 1]) translate([20-j*32, 2.5+i*-12.5+j*7.5, 0]) rotate([0, 0, j*180]) difference() {
    cube([5, 7.5, 5]);
    translate([0, 11, 5]) rotate([90, 0, 0]) cylinder(d=10.3, h=12, $fn=64);
}