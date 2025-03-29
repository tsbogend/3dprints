// SPDX-License-Identifier: GPL-2.0

base = [250, 30, 0.6];
spacer_h = 1.8;
wall = 1;


cube(base);
cube([base.x, 5, spacer_h]);
translate([0, base.y - wall, 0])
	cube([base.x, wall, spacer_h]);
