// SPDX-License-Identifier: GPL-2.0

generate = "all";

$fn = 128;

wall = 3;

cableduct_h = 16;
cableduct_w = 30.5;
cableduct = [ 140, 30.5, 16 ];

box_dia = 110;
box_h = 30;

thread_dia = box_dia - 3;
thread_h = 3;

cover_h = 2;

screw_dist = cableduct.y / 2 + (box_dia - cableduct.y) / 5;

use <openscad-threads/threads.scad>;

module screw_sunk(
	l=20,   //length
	dh = 6.7,   //head dia
	lh = 2.2,   //head length
	ds = 3.5,  //shaft dia
	)
{
        cylinder(h=lh, r1=dh/2, r2=ds/2);
        cylinder(h=l, r=ds/2);
}


module base()
{
	difference() {
		union() {
			ScrewThread(outer_diam = thread_dia + 1.2, height = thread_h, pitch = 1);
			translate([0, 0, thread_h])
				cylinder(d = box_dia, h = box_h);
		}
		cylinder(d = box_dia - 2 * wall, h = box_h);
		translate([-cableduct.x / 2, - cableduct.y / 2, box_h + thread_h - cableduct.z])
			cube(cableduct);
		translate([0, screw_dist, box_h])
			screw_sunk();
		translate([0, -screw_dist, box_h])
			screw_sunk();
	}
}


module cover()
{
	ScrewHole(outer_diam = thread_dia, height = thread_h, pitch = 1)
		cylinder(d = box_dia, h = thread_h + cover_h);
}

if (generate == "base")
	base();

if (generate == "cover")
	cover();

if (generate == "all") {
	base();
	translate([box_dia + 20, 0, 0])
		cover();
}

