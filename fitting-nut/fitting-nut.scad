// SPDX-License-Identifier: GPL-2.0

$fn = 64;

plate_dia = 30;
outer_dia = 14.5;
thread_dia = 12.3;
h = 20;
wall = 1.6;

use <openscad-threads/threads.scad>;

ScrewHole(outer_diam = thread_dia, height = h, pitch = 1.75)
	cylinder(d = outer_dia, h + wall);
translate([0, 0, h])
	cylinder(d = plate_dia, wall);
translate([plate_dia / 2 - 3, -5, 0])
	cube([2, 10, h + wall]);
translate([-plate_dia / 2 + 1, -5, 0])
	cube([2, 10, h + wall]);

