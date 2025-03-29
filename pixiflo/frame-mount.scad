// SPDX-License-Identifier: GPL-2.0

$fn = 128;

frame = [50, 20, 3];
inner = [frame.x, 5, frame.z + 4];

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

difference() {
	union() {
		cube(frame);
		translate([0, frame.y, 0])
			cube(inner);
	}
	translate([10, frame.y / 2, 0])
		screw_sunk();
	translate([frame.x - 10, frame.y / 2, 0])
		screw_sunk();
}
