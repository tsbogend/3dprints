all:	junction_base.stl junction_cover.stl

junction_base.stl: junctionbox.scad
	openscad --export-format binstl -D 'generate="base"' -o $@ $<

junction_cover.stl: junctionbox.scad
	openscad --export-format binstl -D 'generate="cover"' -o $@ $<
