// SPDX-License-Identifier: GPL-2.0

generate="all";

rods_dist = 170;
rods_dia = 8.1;
outer_r = 2;
stand_thick = 8;
stand_height = 90;

holder_base = [70, 75, 3];
holder_wall = [3, 30, 10];
holder_nut_h = 1.5;
holder_nut_dia = 6.7;
holder_nut_d = 7;
holder_tilt = 5;
holder_edge_r = 19;

holder_middle = [stand_thick + 2 * holder_wall.x + 20, 40, holder_base.z];

module rod_stand() {
	difference() {
		hull() {
			translate([outer_r, outer_r, 0])
				cylinder(r = outer_r, h = stand_thick, $fn = 128);
			translate([outer_r, stand_height + outer_r, 0])
				cylinder(r = outer_r, h = stand_thick, $fn = 128);
			translate([rods_dist + rods_dia + 3 * outer_r, outer_r, 0])
				cylinder(r = outer_r, h = stand_thick, $fn = 128);
			translate([rods_dist + rods_dia + 3 * outer_r, stand_height + outer_r, 0])
				cylinder(r = outer_r, h = stand_thick, $fn = 128);
		}
		hull() {
			translate([rods_dia, 0, 0])
				cylinder(d = rods_dia, h = stand_thick, $fn = 128);
			translate([rods_dia, rods_dia, 0])
				cylinder(d = rods_dia, h = stand_thick, $fn = 128);
		}
		hull() {
			translate([rods_dist + rods_dia, 0, 0])
				cylinder(d = rods_dia, h = stand_thick, $fn = 128);
			translate([rods_dist + rods_dia, rods_dia, 0])
				cylinder(d = rods_dia, h = stand_thick, $fn = 128);
		}
		hull() {
			translate([rods_dia * 3, 0, 0])
				cylinder(d = rods_dia * 2, h = stand_thick, $fn = 128);
			translate([rods_dia * 5, stand_height - 2 * rods_dia, 0])
				cylinder(d = rods_dia * 2, h = stand_thick, $fn = 128);
			translate([rods_dist - rods_dia, 0, 0])
				cylinder(d = rods_dia * 2, h = stand_thick, $fn = 128);
			translate([rods_dist - 3 * rods_dia, stand_height - 2 * rods_dia, 0])
				cylinder(d = rods_dia * 2, h = stand_thick, $fn = 128);
				
		}
		translate([0, stand_height + 2 * outer_r - holder_base.z - holder_wall.z / 2, 0]) {
			translate([holder_nut_d, 0, 0])
				cylinder(d = 3.1, h = stand_thick, $fn = 64);
			translate([holder_wall.y - holder_nut_d, 0, 0])
				cylinder(d = 3.1, h = stand_thick, $fn = 64);
		}
	}
}

module screw_sunk(
        l=20,   //length
        dh = 6,   //head dia
        lh = 3,   //head length
        ds = 3.1,  //shaft dia
        )
{
        cylinder(h=lh, r1=dh/2, r2=ds/2, $fn=24);
        cylinder(h=l, r=ds/2, $fn=24);
}

module holder_base()
{
	intersection() {
		cube([holder_base.x + 5, holder_base.y + 5, holder_base.z]);
		hull() {
			translate([1, 1, 0])
				cylinder(r = 1, h = 10, $fn = 64);
			translate([1, holder_base.y - 1, 0])
				rotate([-holder_tilt, 0, 0])
					cylinder(r = 1, h = 10, $fn = 64);
			translate([holder_base.x - 1, 1, 0])
				rotate([0, holder_tilt, 0])
					cylinder(r = 1, h = 10, $fn = 64);
			translate([holder_base.x - holder_edge_r, holder_base.y - holder_edge_r, -2])
				rotate([-holder_tilt, holder_tilt, 0])
					cylinder(r = holder_edge_r, h = 10, $fn = 64);
		}
	}
}

module holder_nut()
{
	cylinder(d = 3.1, h = holder_base.z, $fn = 64);
	translate([0, 0, holder_nut_h])
		cylinder(d = holder_nut_dia, h = holder_base.z - holder_nut_h, $fn = 6);
}

module holder_side(n)
{
	difference() {
		cube(holder_wall);
		translate([0, holder_nut_d, holder_wall.z / 2])
			rotate([0, 90, 00])
				if (n)
					holder_nut();
				else
					screw_sunk();
		translate([0, holder_wall.y - holder_nut_d, holder_wall.z / 2])
			rotate([0, 90, 00])
				if (n)
					holder_nut();
				else
					screw_sunk();
	}
}


module stand_holder()
{
	difference() {
		holder_base();
		translate([holder_wall.x + 10, 0, 0])
			cube([stand_thick, holder_wall.y, holder_base.z]);
		translate([holder_base.x - 6, 10, 0])
			holder_nut();
		translate([6, 10, 0])
			holder_nut();
		translate([6, holder_base.y - 10, 0])
			holder_nut();
	}
	translate([10, 0, 0]) {
		translate([0, 0, holder_base.z])
			holder_side(false);
		translate([stand_thick + holder_wall.x, 0, holder_base.z])
			holder_side(true);
	}
}

module middle_base()
{
	intersection() {
		cube([holder_middle.x + 5, holder_middle.y + 5, holder_middle.z]);
		hull() {
			translate([1, 1, 0])
				cylinder(r = 1, h = 10, $fn = 64);
			translate([1, holder_middle.y - 1, 0])
				rotate([-holder_tilt, 0, 0])
					cylinder(r = 1, h = 10, $fn = 64);
			translate([holder_middle.x - 1, 1, 0])
				cylinder(r = 1, h = 10, $fn = 64);
			translate([holder_middle.x - 1, holder_middle.y - 1, -2])
				rotate([-holder_tilt, holder_tilt, 0])
					cylinder(r = 1, h = 10, $fn = 64);
		}
	}
}

module middle_holder()
{
	difference() {
		middle_base();
		translate([holder_wall.x + 10, 0, 0])
			cube([stand_thick, holder_wall.y, holder_base.z]);
		translate([6, 10, 0])
			holder_nut();
		translate([holder_middle.x - 6, holder_middle.y - 10, 0])
			holder_nut();
	}
	translate([10, 0, 0]) {
		translate([0, 0, holder_base.z])
			holder_side(false);
		translate([stand_thick + holder_wall.x, 0, holder_base.z])
			holder_side(true);
	}
}



if (generate == "rod_stand")
	rod_stand();

if (generate == "left_holder")
	stand_holder();

if (generate == "middle_holder")
	middle_holder();

if (generate == "right_holder")
	mirror([1, 0, 0])
		stand_holder();

if (generate == "all") {
	translate([0, 100, 0])
		rod_stand();
	stand_holder();
	translate([80, 0, 0])
		middle_holder();
	translate([195, 0, 0])
		mirror([1, 0, 0])
			stand_holder();
}
