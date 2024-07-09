all:	eap615_mount.stl eap615_lock.stl

eap615_mount.stl: eap615-mount.scad
	openscad --export-format binstl -D 'generate="eap615_mount"' -o $@ $<

eap615_lock.stl: eap615-mount.scad
	openscad --export-format binstl -D 'generate="eap615_lock"' -o $@ $<
