// SPDX-License-Identifier: GPL-2.0

generate="both";

$fn = 128;

base = [100, 32, 5.5];
easy_wall = [base.x, 2, 41];

easy_notch_width = 3;
easy_notch_dist = 85;
easy_notch_height = 26;
easy_notch_thick = 1.5;

easy_notch_mid = 65;
easy_notch_mid_w = 5;
easy_notch_mid_h = 35;
easy_notch_dip_w = 8;

easy_mid_h = 39;
easy_mid_w = 70;

led_info_d = 3.9;
led_info_x = 83;
led_info_y = 5.5;

led_flash_d = 3.5;
led_flash_x = 17;
led_flash_y = 11;

mount_y = 2.6;
mount_out_dia = 8.6;
mount_in_dia = 4.5;
mount_h = 3;
mounts_dist = 62.5;

mount_screw_head_dia = 6.7;
mount_screw_head_h = 25;

screw_dia = 3;

overlap = 2;

cover = [base.x, base.y, 15];
cover_wall = 2;
cover_in = [cover.x - 2 * cover_wall,
	    cover.y - 2 * cover_wall,
	    cover.z - cover_wall];

cover_in_h = cover_in.z - overlap;

usb = [9.7, 6.2, 0];
usb_dia = usb.y;
usb_dist = usb.x - usb_dia;

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

screw_offs_1 = cover.x / 3;
screw_offs_2 = (2 * cover.x) / 3;

module screw_block()
{
	translate([screw_offs_1, cover.y / 2, cover_wall])
		difference() {
			cylinder(d = screw_dia + 2, h = cover.z - overlap - cover_wall);
			cylinder(d = screw_dia - 0.2, h = cover.z - overlap - cover_wall);
	}
	translate([screw_offs_2, cover.y / 2, cover_wall])
		difference() {
			cylinder(d = screw_dia + 2, h = cover_in_h);
			cylinder(d = screw_dia - 0.2, h = cover_in_h);
	}
}

esp_in = [26, 35, cover.z];
esp_out = [esp_in.x + 2 * cover_wall,
	   esp_in.y + 2 * cover_wall,
	   cover.z];

esp_depth = cover_in.z - overlap - 4.5;

module esp_block()
{
	translate([(base.x - esp_out.x) / 2 + cover_wall, cover_wall, cover_wall])
		cube([esp_in.x, 4, esp_depth]);
	translate([(base.x - esp_out.x) / 2 + cover_wall, esp_in.y + cover_wall - 1 , cover_wall])
		cube([(esp_in.x - usb.x) / 2, 1, esp_depth]);
	translate([(base.x - esp_out.x) / 2 + cover_wall + esp_in.x - (esp_in.x - usb.x) / 2, esp_in.y + cover_wall - 1 , cover_wall])
		cube([(esp_in.x - usb.x) / 2, 1, esp_depth]);
}

mount_fl_dia = 26;
mount_fl_w = 24.1;
mount_fl_th = 1.5;

module flash_block()
{
	translate([led_flash_x, (mount_fl_dia + 2) / 2, cover_wall])
		intersection() {
			difference() {
				cylinder(d = mount_fl_dia + 2, h = cover_in_h); 
				translate([0, 0, cover_in_h - mount_fl_th])
					cylinder(d = mount_fl_dia, h = mount_fl_th); 
				cylinder(d = mount_fl_dia - 3, h = cover_in_h); 
			}
			translate([-(mount_fl_dia + 2) / 2,
				   -mount_fl_dia / 2 + (mount_fl_dia - mount_fl_w) / 2,
				 0])
				cube([mount_fl_w, mount_fl_w, cover_in_h]);
	}
}

mount_info_x = 11.2;
mount_info_y = 15.2;
mount_info_th = 1.9;

module info_block()
{
	translate([led_info_x - mount_info_x / 2 - cover_wall, 0, cover_wall])
		difference() {
			cube([mount_info_x + 2 * cover_wall,
			      mount_info_y + 2 * cover_wall,
			      cover_in_h]);
			translate([cover_wall, cover_wall, cover_in_h - mount_info_th])
				cube([mount_info_x, mount_info_y, mount_info_th]);
			translate([2 * cover_wall, cover_wall, 0])
				cube([mount_info_x - 2 * cover_wall,
				      mount_info_y + cover_wall, cover_in_h]);
		}
}

module cover()
{
	difference() {
		union() {
			cube(cover);
			translate([(base.x - esp_out.x) / 2, 0, 0])
				cube(esp_out);
		}
		translate([cover_wall, cover_wall, cover_wall])
			cube(cover_in);
		translate([(base.x - esp_out.x) / 2 + cover_wall, cover_wall, cover_wall])
			cube(esp_in);
		translate([(base.x - usb_dist) / 2, esp_in.y + cover_wall, cover.z - overlap - 5]) {
			rotate([-90, 0, 0]) hull() {
				cylinder(d = usb_dia, h = cover_wall);
				translate([usb_dist, 0, 0])
					cylinder(d = usb_dia, h = cover_wall);
			}
		}
	}
	screw_block();
	esp_block();
	flash_block();
	info_block();
}

module notch()
{
	cube([easy_notch_width, easy_wall.y, easy_wall.z - easy_notch_height]);
	translate([-easy_notch_dip_w / 2, easy_notch_thick, 0])
		cube([easy_notch_width + easy_notch_dip_w, easy_wall.y - easy_notch_thick, easy_wall.z - easy_notch_height]);
}

module mount()
{
	translate([0, 0, -mount_h / 2]) difference() {
		cylinder(d = mount_out_dia, h = mount_h, center = true);
		cylinder(d = mount_in_dia, h = mount_h, center = true);
	}
}

module main()
{
	difference() {
		union() {
			cube(base);
			translate([0, base.y - easy_wall.y, base.z])
				cube(easy_wall);
			translate([(base.x - esp_out.x) / 2, 0, 0])
				cube([esp_out.x, esp_out.y, base.z]);
		}
		translate([(base.x - easy_notch_dist - easy_notch_width) / 2,
			   base.y - easy_wall.y, easy_notch_height + base.z]) {
			notch();
			translate([easy_notch_dist, 0, 0])
				notch();
		}	
		translate([easy_notch_mid, base.y - easy_wall.y, easy_notch_mid_h + base.z])
			cube([easy_notch_mid_w, easy_wall.y, easy_wall.z - easy_notch_mid_h]);
		translate([(base.x - easy_mid_w) / 2, base.y - easy_wall.y, easy_mid_h + base.z])
			cube([easy_mid_w, easy_wall.y, easy_wall.z - easy_mid_h]);
		translate([led_info_x, led_info_y, 0])
			cylinder(d = led_info_d, h = base.z);
		translate([led_flash_x, led_flash_y, 0])
			cylinder(d = led_flash_d, h = base.z);
		translate([(base.x - mounts_dist) / 2, base.y + mount_y, easy_mid_h + base.z - mount_h / 2])
			cylinder(d = mount_screw_head_dia, h = mount_screw_head_h, center = true);
		translate([base.x - (base.x - mounts_dist) / 2, base.y + mount_y, easy_mid_h + base.z - mount_h / 2])
			cylinder(d = mount_screw_head_dia, h = mount_screw_head_h, center = true);
		translate([screw_offs_1, base.y / 2, base.z])
			mirror([0, 0, 1])
				screw_sunk(l=10, dh=6, lh=3, ds=screw_dia);
		translate([screw_offs_2, base.y / 2, base.z])
			mirror([0, 0, 1])
				screw_sunk(l=10, dh=6, lh=3, ds=screw_dia);
		translate([0, 0, -cover.z + overlap])
			cover();
	}
	translate([(base.x - mounts_dist) / 2, base.y + mount_y, easy_mid_h + base.z])
		mount();
	translate([base.x - (base.x - mounts_dist) / 2, base.y + mount_y, easy_mid_h + base.z])
		mount();
}

if (generate == "holder")
	main();

if (generate == "cover")
	cover();

if (generate == "both") {
	main();
	translate([0, base.y + 20, 0])
		cover();
}
