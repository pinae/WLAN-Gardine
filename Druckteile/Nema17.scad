module Nema17() {
    holeDistance = 31;
    width = 42.2;
    height = 46.95;
    diagonal = 53.85;
    raisedCylinderDiameter = 22;
    raisedCylinderHeight = 2.16;
    screwHoleDepth = 2.65;
    screwHoleDiameter = 6.15;
    screwDiameter = 3;
    diameter = 5;
    fullHeight = 70.82;
    rimHeight = 8;

    color("Cyan") render(convexity=4) difference() {
        union() {
            cylinder(d=diagonal, h=rimHeight, $fn=128);
            cylinder(d=diagonal-2, h=height, $fn=128);
            translate([0, 0, height-rimHeight]) {
                cylinder(d=diagonal, h=rimHeight, $fn=128);
            }
            translate([0, 0, height]) {
                cylinder(d=raisedCylinderDiameter, h=raisedCylinderHeight, $fn=64);
            }
            color("Cyan") {
                cylinder(d=diameter, h=fullHeight, $fn=32);
            }
        }
        for(i = [-3, 1]) {
            translate([i*width/2, -width/2, -1]) {
                cube([width, width, height+2]);
            }
            translate([-width/2, i*width/2, -1]) {
                cube([width, width, height+2]);
            }
        }
        for(x = [-1, 1]) {
            for(y = [-1, 1]) {
                translate([x*holeDistance/2, y*holeDistance/2, -1]) {
                    cylinder(d=screwHoleDiameter, h=screwHoleDepth+1, $fn=32);
                    cylinder(d=screwDiameter, h=height+2, $fn=16);
                }
            }
        }
    }
}
Nema17();