// SPDX-License-Identifier: GPL-2.0

$fn = 128;

base = [45, 10, 3];
cable_d = 5.6;
wall = 3;

module screw_sunk(
        l=20,   //length
        dh = 6,   //head dia
        lh = 3,   //head length
        ds = 3.2,  //shaft dia
        )
{
        cylinder(h=lh, r1=dh/2, r2=ds/2);
        cylinder(h=l, r=ds/2);
}

module cable_out()
{
	translate([0, base.y, cable_d / 2 -1 ]) rotate([90, 0, 0])
		hull() {
			translate([15, 0, 0])
				cylinder(d = cable_d + 2 * wall, h = base.y);
			translate([base.x - 15, 0, 0])
				cylinder(d = cable_d + 2 * wall, h = base.y);
		}
}
module cable_in()
{
	translate([0, base.y, cable_d / 2 - 1]) rotate([90, 0, 0]) {
		translate([15, 0, 0])
			cylinder(d = cable_d, h = base.y);
		translate([base.x - 15, 0, 0])
			cylinder(d = cable_d, h = base.y);
	}
}

intersection() {
	difference() {
		union() {
			cube(base);
			cable_out();
		}
		cable_in();
	
		translate([5, base.y / 2, base.z])
			rotate([180, 0, 0])
				screw_sunk();
		translate([base.x - 5, base.y / 2, base.z])
			rotate([180, 0, 0])
				screw_sunk();
		translate([base.x / 2, base.y / 2, cable_d + wall -1])
			rotate([180, 0, 0])
				screw_sunk();
	}
	cube([base.x, base.y, cable_d + wall - 1]);
}
