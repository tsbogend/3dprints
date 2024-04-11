all:	cover.stl holder.stl

cover.stl: easymeter.scad
	openscad --export-format binstl -D 'generate="cover"' -o $@ $<

holder.stl: easymeter.scad
	openscad --export-format binstl -D 'generate="holder"' -o $@ $<
