all:	pixiflo_15x15_l.stl pixiflo_14x14_r.stl \
	pixiflo_14x15_l.stl pixiflo_15x14_r.stl

pixiflo_15x15_l.stl: pixiflo.scad
	openscad --export-format binstl -D n_pix_x=15 -D n_pix_y=15 -D corner=true -D left=true -o $@ $<

pixiflo_14x14_r.stl: pixiflo.scad
	openscad --export-format binstl -D n_pix_x=14 -D n_pix_y=14 -D corner=true -D right=true -o $@ $<

pixiflo_14x15_l.stl: pixiflo.scad
	openscad --export-format binstl -D n_pix_x=14 -D n_pix_y=15 -D corner=true -D left=true -o $@ $<

pixiflo_15x14_r.stl: pixiflo.scad
	openscad --export-format binstl -D n_pix_x=15 -D n_pix_y=14 -D corner=true -D right=true -o $@ $<
