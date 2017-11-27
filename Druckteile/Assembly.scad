use <Antriebsrolle2.scad>
use <Umlenkrolle.scad>
use <Umlenkrolle_Halter.scad>
use <Ringzieher.scad>
use <Motorhalter.scad>
use <Nema17.scad>

//translate([0, 0, 4.5]) rotate([180, 0, 0]) antriebsrolle();
translate([0, 0, 0.25]) rotate([180, 0, 0]) rope_wheel();
translate([150, 0, -4]) umlenkrolle();
translate([70, 0, 0]) rotate([0, -90, 0]) ringzieher(true);
translate([56, 0, 0]) rotate([0, -90, 180]) ringzieher(false);
translate([0, 0, -65]) Nema17();
translate([0, 0, -18]) motorhalter();
translate([0, 0, 33-18]) motorhalter_klemme();
color("Silver") translate([-30, 0, 15]) rotate([0, 90, 0]) cylinder(d=10, h=210, $fn=32);
translate([150, 0, -3.5]) umlenrolle_halter();
translate([150, 0, -10.5]) umlenrolle_gegenstueck();
translate([150, 0, 15]) umlenrolle_klemme();