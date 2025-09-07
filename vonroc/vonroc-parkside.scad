// SPDX-License-Identifier: GPL-2.0

$fn = 256;

parkside_d = 35;
parkside_h = 40;

vonroc_d = 39;
vonroc_h = 33;
vonroc_notch_d = 41.5;
vonroc_notch_w = 5;

transition_h = 5;

tpu_off = 0.3;

wall = 2;

module parkside()
{
	difference() {
		cylinder(h = parkside_h, d = parkside_d - tpu_off + 2 * wall);
		cylinder(h = parkside_h, d = parkside_d - tpu_off);
	}
}

module vonroc()
{
	difference() {
		cylinder(h = vonroc_h, d = vonroc_notch_d - tpu_off + 2 * wall);
		cylinder(h = vonroc_h, d = vonroc_d - tpu_off);
		intersection() {
			cylinder(h = vonroc_h, d = vonroc_notch_d - tpu_off);
			translate([0, 0, vonroc_h / 2])
				cube([vonroc_notch_w,
				      vonroc_notch_d + 10,
				      vonroc_h], center = true);
		}
	}
}

module transition()
{
	difference() {
		cylinder(h = transition_h,
			 d1 = vonroc_notch_d - tpu_off + 2 * wall,
			 d2 = parkside_d - tpu_off + 2 * wall);
		cylinder(h = transition_h,
			 d1 = vonroc_d - tpu_off,
			 d2 = parkside_d - tpu_off);
	}
}


vonroc();
translate([0, 0, vonroc_h])
	transition();
translate([0, 0, vonroc_h + transition_h])
	parkside();

