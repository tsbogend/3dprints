// SPDX-License-Identifier: GPL-2.0

generate = "all";

$fn = 64;

use <openscad-threads/threads.scad>;

wall = 2;
bottom = 3;
rail_h = 7.7;
rail_w = 34.7;
rail_mount_y = 10;
rail_mount_w = 10;

rail_in = [20, rail_mount_w, 5.8];

mount_d = 13;
mount_w = 60;
mount_th_d = 4;

square_nut = 5.5;

base = [49, 54, 30];
inner = [base.x - 2 * wall, base.y - 2 * wall, base.z - bottom - rail_h];

module mount(offset)
{
	intersection() {
		ScrewHole(outer_diam = mount_th_d, height = base.z)
			cylinder(d = mount_d, h = base.z);
		translate([offset, 0, 0])
			cube([mount_d, mount_th_d + 2, 2 * base.z], center = true);
	}
}

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

module eap615_mount()
{
	difference() {
		cube(base);
		translate([wall, wall, bottom + rail_h])
			cube(inner);
		translate([(base.x - rail_w) / 2, 0, 0])
			cube([rail_w, base.y, rail_h]);
		translate([(base.x - rail_w) / 2, wall, 0])
			cube([rail_w, rail_mount_y - wall, rail_h + bottom]);
		translate([(base.x - rail_w) / 2, rail_mount_y + rail_mount_w, 0])
			cube([rail_w, base.y - rail_mount_y - rail_mount_w - wall, rail_h + bottom]);
		translate([base.x / 2, rail_mount_y + rail_mount_w / 2, rail_h + bottom])
			rotate([0, 180, 0])
				screw_sunk();
		translate([base.x / 2, wall, rail_h])
			rotate([90, 0, 0])
				cylinder(d = rail_w, h = wall);
		translate([base.x / 2, base.y, rail_h])
			rotate([90, 0, 0])
				cylinder(d = rail_w, h = wall);
	}
	translate([-(mount_w - base.x) / 2,  base.y / 2, 0]) {
		mount(3.5);
		translate([mount_w, 0, 0])
			mount(-3.5);
	}
}

module eap615_lock()
{
	difference() {
		cube(rail_in);
		translate([rail_in.x / 2, rail_in.y / 2, 0])
			cylinder(d = 3.1, h = rail_in.z);
		translate([(rail_in.x - square_nut) / 2, (rail_in.y - square_nut)/ 2, 1])
			cube([square_nut, rail_in.y, 1.8]);
	}
}

if (generate == "eap615_mount")
	eap615_mount();

if (generate == "eap615_lock")
	eap615_lock();

if (generate == "all") {
	eap615_mount();
	translate([0, -20, 0])
		eap615_lock();
}
	



