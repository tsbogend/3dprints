// SPDX-License-Identifier: GPL-2.0

generate="both";

base = [46.9, 9.3, 2];
pin_in_h = 21;
pin_in_1 = [9.6, 6.8, pin_in_h];
pin_in_2 = [16.8, 6.8, pin_in_h];
pin_in_dia = 1;
pin_out = [42.1, 6, 8.0];
pin_out_cut = 5;
pin_out_side_poly = [ [0, 0], [0, 6.5],
		      [6, pin_out.z], [37.6, pin_out.z],
		      [pin_out.x, 5.6], [pin_out.x, 0] ];
pin_out_top_poly  = [ [0, 1.8], [8.8, 0],
		      [pin_out.x, 0], [pin_out.x, pin_out.y],
		      [8.8, pin_out.y], [0, 4.2] ];

latch = [8.2, 2, 45.8];
latch_plugin = [latch.x + 0.4, latch.y + 0.4, latch.z];
latch_poly = [ [0, 0], [latch.x, 0],
	        [latch.x, latch.z - latch.x / 2],
		[latch.x / 2, latch.z],
	        [0, latch.z - latch.x / 2],
		[0, latch.z] ];
latch_pin = pin_out_cut - 0.2;
latch_pin_l = latch_pin / 2;
latch_pin_poly = [ [0, 0], [latch_pin, 0], [latch_pin_l, latch_pin_l] ];

module mod_base()
{
	difference() {
		cube(base);
		translate([0, 0, 1])
			rotate([30, 0, 0])
				cube(base);
		translate([0, base.y, 1])
			rotate([-30, 0, 0])
				translate([0, -base.y, 0])
					cube(base);
	}
}

module mod_pin_in_1()
{
	translate([pin_in_dia / 2, pin_in_dia / 2, 0]) hull() {
		cylinder(h = pin_in_1.z, d = pin_in_dia, $fn = 128);
		translate([0, pin_in_1.y - pin_in_dia, 0])
			cylinder(h = pin_in_1.z, d = pin_in_dia, $fn = 128);
		translate([pin_in_1.x - pin_in_dia, 0, 0])
			cylinder(h = pin_in_1.z, d = pin_in_dia, $fn = 128);
		translate([pin_in_1.x - pin_in_dia, pin_in_1.y - pin_in_dia, 0])
			cylinder(h = pin_in_1.z, d = pin_in_dia, $fn = 128);
	}
}

module mod_pin_in_2()
{
	translate([pin_in_dia / 2, pin_in_dia / 2, 0]) hull() {
		cylinder(h = pin_in_2.z, d = pin_in_dia, $fn = 128);
		translate([0, pin_in_2.y - pin_in_dia, 0])
			cylinder(h = pin_in_2.z, d = pin_in_dia, $fn = 128);
		translate([pin_in_2.x - pin_in_dia, 0, 0])
			cylinder(h = pin_in_2.z, d = pin_in_dia, $fn = 128);
		translate([pin_in_2.x - pin_in_dia, pin_in_2.y - pin_in_dia, 0])
			cylinder(h = pin_in_2.z, d = pin_in_dia, $fn = 128);
	}
}

module mod_pin_out()
{
	intersection() {
		difference() {
			cube(pin_out);
			translate([25.2, 0, 0])
				cube([pin_out_cut, pin_out.y, pin_out.z]);
		}
		translate([0, pin_out.y, 0])
			rotate([90, 0, 0])
				linear_extrude(height = pin_out.y, $fn = 128)
					polygon(pin_out_side_poly);
		linear_extrude(height = pin_out.z)
			polygon(pin_out_top_poly);
	}
}

module mod_plugin()
{
	difference() {
		union() {
			mod_base();
			translate([10.1, (base.y - pin_in_1.y) / 2, -pin_in_1.z])
				mod_pin_in_1();
			translate([21.4, (base.y - pin_in_2.y) / 2, -pin_in_2.z])
				mod_pin_in_2();
			translate([0, (base.y - pin_out.y) / 2, base.z])
				mod_pin_out();
		}
		translate([25.2 - (latch.x - pin_out_cut) / 2, (base.y - latch.y) / 2, -pin_in_h])
			cube(latch_plugin);
	}
}

module mod_latch()
{
	linear_extrude(height = latch.y)
		polygon(latch_poly);
	translate([(latch.x - latch_pin) / 2,
		   latch.z - latch_pin_l, -(12.4 - latch.y) / 2])
		linear_extrude(height = 12.4)
			polygon(latch_pin_poly);
}

if (generate == "plugin")
	mod_plugin();

if (generate == "latch")
	mod_latch();

if (generate == "both") {
	mod_plugin();
	translate([0, 30, 0])
		mod_latch();
}

