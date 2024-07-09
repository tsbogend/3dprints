all:	base.stl cover.stl strain.stl

base.stl: head.scad
	openscad --export-format binstl -D 'generate="base"' -o $@ $<

cover.stl: head.scad
	openscad --export-format binstl -D 'generate="cover"' -o $@ $<

strain.stl: head.scad
	openscad --export-format binstl -D 'generate="strain"' -o $@ $<
