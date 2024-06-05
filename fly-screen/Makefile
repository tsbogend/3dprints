all:	plugin.stl latch.stl

plugin.stl: fly-screen.scad
	openscad --export-format binstl -D 'generate="plugin"' -o $@ $<

latch.stl: fly-screen.scad
	openscad --export-format binstl -D 'generate="latch"' -o $@ $<
