// SPDX-License-Identifier: GPL-2.0

n_pix_x = 5;
n_pix_y = 5;

corner = true;
bottom = true;
left = true;
right = true;
top = true;

led_h = 4;
led_w = 5.8;
pix_l = 16.7;
plate_h = 0;
wall = 1;
stripe_w = 10.5;
stripe_h = 1;
pix_h = plate_h + led_h + stripe_h;

border_w = 8.2;
border_h = 1.7;
border_thick = 1;
border_wall = 2;
corner_l = 40;

prism_h = 1;

module pixel()
{
	difference() {
		cube([pix_l, pix_l, pix_h]);
		translate([wall, wall, plate_h])
			cube([pix_l - 2 * wall, pix_l - 2 * wall, prism_h]);
		hull() {
			translate([(pix_l - led_w) / 2,
				   (pix_l - led_w) / 2, led_h - 0.6])
				cube([led_w, led_w, 0.6]);
			translate([wall, wall, prism_h])
				cube([pix_l - 2 * wall, pix_l - 2 * wall, 0.1]);
		}
		translate([(pix_l - stripe_w) / 2, 0, plate_h + led_h])
			cube([stripe_w, pix_l, stripe_h]);
	}
}

module do_corner()
{
	cube([border_w, border_w, border_thick]);
	cube([corner_l, border_wall, pix_h]);
	cube([border_wall, corner_l, pix_h]);
}

for(x = [0 : n_pix_x - 1])
	for(y = [0 : n_pix_y - 1])
		translate([x * pix_l, y * pix_l, 0])
			pixel();

if (left) {
	translate([-border_w, 0, 0]) {
		cube([border_w, n_pix_y * pix_l, border_thick]);
		cube([border_wall, n_pix_y * pix_l, border_h]);
	}
}

if (right) {
	translate([n_pix_x * pix_l, 0, 0]) {
		cube([border_w, n_pix_y * pix_l, border_thick]);
		translate([border_w - border_wall, 0, 0])
			cube([border_wall, n_pix_y * pix_l, border_h]);
	}
}

if (bottom) {
	translate([0, -border_w, 0]) {
		cube([n_pix_x * pix_l, border_w, border_thick]);
		cube([n_pix_x * pix_l, border_wall, border_h]);
	}
}

if (top) {
	translate([0, n_pix_y * pix_l, 0]) {
		cube([n_pix_x * pix_l, border_w, border_thick]);
		translate([0, border_w - border_wall])
			cube([n_pix_x * pix_l, border_wall, border_h]);
	}
}

if (corner) {
	if (left && bottom)
		translate([-border_w, -border_w, 0])
			do_corner();
	if (left && top)
		translate([-border_w, n_pix_y * pix_l + border_w, 0])
			rotate([0, 0, 270])
				do_corner();

	if (right && bottom)
		translate([border_w + n_pix_x * pix_l, -border_w, 0])
			rotate([0, 0, 90])
				do_corner();

	if (right && top)
		translate([border_w + n_pix_x * pix_l, n_pix_y * pix_l + border_w, 0])
			rotate([0, 0, 180])
				do_corner();
}
