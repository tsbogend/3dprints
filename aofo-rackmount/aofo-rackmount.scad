// SPDX-License-Identifier: GPL-2.0

aofo = [330, 78, 37.5];
aofo_r = 10;
rack_w = 480;
overlap = 40;
overlap_aofo_x = 16;
overlap_aofo_y = 9;
wall = 3;
dia = 6.7;
hole_d1 = 7.5;
hole_d2 = 45;

base = [(rack_w - aofo.x) / 2 + overlap, aofo.y + 2 * wall, wall];

module aofo()
{
	hull() {
		translate([aofo_r, aofo_r, 0])
			cylinder(r = aofo_r, h = aofo.z, $fn = 128);
		translate([aofo_r, aofo.y - aofo_r, 0])
			cylinder(r = aofo_r, h = aofo.z, $fn = 128);
		translate([aofo.x - aofo_r, aofo_r, 0])
			cylinder(r = aofo_r, h = aofo.z, $fn = 128);
		translate([aofo.x - aofo_r, aofo.y - aofo_r, 0])
			cylinder(r = aofo_r, h = aofo.z, $fn = 128);
	}
}

difference()
{
	union() {
		cube(base);
		translate([base.x - overlap - wall, 0, base.z])
			cube([overlap + wall, base.y, aofo.z + wall]);
	}
	translate([base.x - overlap, wall, base.z])
		aofo();
	
	translate([hole_d1, (base.y - hole_d2) / 2, 0]) {
		cylinder(d = dia, h = base.z, $fn = 128);
		translate([0, hole_d2, 0])
			cylinder(d = dia, h = base.z, $fn = 128);
	}
	translate([base.x - overlap + overlap_aofo_x, wall, 0])
		hull() {
			translate([aofo_r, overlap_aofo_y + aofo_r, 0])
				cylinder(r = aofo_r, h = aofo.z + 2 * wall, $fn = 128);
			translate([aofo_r, aofo.y - overlap_aofo_y - aofo_r, 0])
				cylinder(r = aofo_r, h = aofo.z + 2 * wall, $fn = 128);
			translate([aofo_r + overlap, overlap_aofo_y + aofo_r, 0])
				cylinder(r = aofo_r, h = aofo.z + 2 * wall, $fn = 128);
			translate([aofo_r + overlap, aofo.y - overlap_aofo_y - aofo_r, 0])
				cylinder(r = aofo_r, h = aofo.z + 2 * wall, $fn = 128);
	}
	translate([base.x - overlap, base.y / 2, aofo.z / 2 + wall])
		rotate([0, -90, 0])
			hull() {
				translate([0, - 10, 0])
				cylinder(d = aofo.z, h = wall, $fn =128);
				translate([0, 10, 0])
					cylinder(d = aofo.z, h = wall, $fn =128);
			}
}

