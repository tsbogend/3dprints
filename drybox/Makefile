all:	rod_stand.stl left_holder.stl middle_holder.stl right_holder.stl

rod_stand.stl: rod-stand.scad
	openscad --export-format binstl -D 'generate="rod_stand"' -o $@ $<

left_holder.stl: rod-stand.scad
	openscad --export-format binstl -D 'generate="left_holder"' -o $@ $<

middle_holder.stl: rod-stand.scad
	openscad --export-format binstl -D 'generate="middle_holder"' -o $@ $<

right_holder.stl: rod-stand.scad
	openscad --export-format binstl -D 'generate="right_holder"' -o $@ $<
