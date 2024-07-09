// SPDX-License-Identifier: GPL-2.0

generate = "all";

$fn = 128;

led_dia = 4.0;
led_dist = 6.5;
led_h = 7;
magnet_dia = 6.3;
magnet_h = 3.4;
magnet_num = 6;
magnet_dist = 11;
magnet_depth = 0.6;
led_pcb_dia = 26.1;
led_pcb_w = 24.1;
led_pcb_h = 4;
led_solder_dia = 7;
led_solder_h = led_pcb_h + 2;
thread_dia = led_pcb_dia + 3;
thread_h = led_pcb_h;
ring_dia = 32;
ring_h = thread_h + led_h;

use <openscad-threads/threads.scad>;

module magnets()
{
	for (i = [0:360 / magnet_num:360]) {
		rotate([0, 0, i])
			translate([magnet_dist, 0, 0])
				cylinder(d = magnet_dia, h = magnet_h);
	}
}

module led_pcb()
{
	intersection() {
			cylinder(d = led_pcb_dia, h = led_pcb_h); 

			translate([-led_pcb_dia / 2 + (led_pcb_dia - led_pcb_w) / 2,
				   -led_pcb_dia / 2, 0])
                                cube([led_pcb_w, led_pcb_dia, led_pcb_h]);
        }
}

module led_holes()
{
	translate([-led_dist / 2, 0, 0])
		cylinder(d = led_dia, h = ring_h);
	translate([led_dist / 2, 0, 0])
		cylinder(d = led_dia, h = ring_h);
	hull() {
		translate([-led_dist / 2, 0, 0])
			cylinder(d = led_solder_dia, h = led_solder_h);
		translate([led_dist / 2, 0, 0])
			cylinder(d = led_solder_dia, h = led_solder_h);
	}
}

module base()
{
	difference() {
		union() {
			ScrewThread(outer_diam = thread_dia, height = thread_h, pitch = 1);
			translate([0, 0, thread_h])
				cylinder(d = ring_dia, h = ring_h - thread_h);
		}
		translate([0, 0, ring_h - magnet_h - magnet_depth])
			magnets();
		led_pcb();
		led_holes();
	}
}

cover_h = 2;
cable_dia = 4.9;
strain_dia = cable_dia + 2;
strain_in_dia = strain_dia + 5;
strain_in_h = 2;
cover_strain_in_h = 1;
strain_h = 10;

module cover()
{
	difference() {
		ScrewHole(outer_diam = thread_dia, height = thread_h, pitch = 1)
			cylinder(d = ring_dia, h = thread_h + cover_h);
		cylinder(d = strain_in_dia, thread_h + cover_h - cover_strain_in_h);
		cylinder(d = strain_dia, thread_h + cover_h);
	}
}



module strain_relief()
{
	difference() {
		union() {
			cylinder(d = strain_in_dia, h = strain_in_h);
			translate([0, 0, strain_in_h])
				cylinder(d = strain_dia, h = strain_h);
		}
		cylinder(d = cable_dia, h = strain_in_h + strain_h);
	}
}


if (generate == "base")
	base();

if (generate == "cover")
	cover();

if (generate == "strain")
	strain_relief();

if (generate == "all") {
	base();
	translate([40, 0, 0])
		cover();
	translate([-30, 00, 0])
		strain_relief();
}

