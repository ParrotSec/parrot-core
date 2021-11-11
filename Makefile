INSTALL=install -m 0644


all:

clean:

install:
	mkdir -p skel/.config/dconf
	dconf compile skel/.config/dconf/user dconf/db/local.d/
	mkdir -p $(DESTDIR)/usr/lib/parrot-skel/etc
	chown root:root -R skel dconf
	chmod 700 -R skel
