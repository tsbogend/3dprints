all:	vonroc_parkside.stl vonroc_parkside_tpu.stl

vonroc_parkside.stl: vonroc-parkside.scad
	openscad --export-format binstl -D tpu_off=0 -o $@ $<

vonroc_parkside_tpu.stl: vonroc-parkside.scad
	openscad --export-format binstl -D tpu_off=0.3 -o $@ $<

