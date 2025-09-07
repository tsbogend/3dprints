// SPDX-License-Identifier: GPL-2.0

$fn = 128;

base = [90, 70, 1.5];

foot = [4, 4, 17];

mount = [9, 9, foot.z + base.z];
mount_w = 1;
mount_screw_dia = 3.2;


dist_hole_x = 77;
dist_hole_y = 62;

hole_x = 4;
hole_y = 4;

module screw_sunk(
        l=5,   //length
        dh = 4.5,   //head dia
        lh = 1,   //head length
        ds = 3,  //shaft dia
        )
{
        cylinder(h=lh, r1=dh/2, r2=ds/2);
        cylinder(h=l, r=ds/2);
}

module mount_to_screw()
{
	difference() {
		cube(mount);
		translate([mount_w, mount_w, mount_w])
			cube([mount.x - mount_w,
			      mount.y - 2 * mount_w,
			      mount.z - mount_w]);
		translate([mount.x / 2, mount.y / 2, 0])
			cylinder(d = mount_screw_dia, h = mount.z);
	}
}

difference() {
	cube(base);
	translate([hole_x, hole_y, 0])
		screw_sunk();
	translate([hole_x + dist_hole_x, hole_y, 0])
		screw_sunk();
	translate([hole_x, base.y - hole_y, 0])
		screw_sunk();
	translate([hole_x + dist_hole_x, base.y - hole_y, 0])
		screw_sunk();
}
translate([15, 0, -foot.z])
	cube(foot);
translate([15, base.y - foot.y - 10, -foot.z])
	cube(foot);
translate([base.x - mount_w, base.y - mount.y, -mount.z + base.z])
	mount_to_screw();
translate([base.x - 5, base.y - mount.y, -10])
	hull() {
		translate([4.9, 0, 0])
			cube([0.1, mount.y, 0.1]);
		translate([0, 0, 10])
			cube([5, mount.y, 0.1]);
	}
