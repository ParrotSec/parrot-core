INSTALL=install -m 0644


all:

clean:

install:
	mkdir -p skel/.config/dconf
	dconf compile skel/.config/dconf/user dconf/db/local.d/
	chmod 700 -R skel
