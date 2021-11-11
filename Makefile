INSTALL=install -m 0644


all:

clean:

install:
	mkdir -p skel/.config/dconf || true
	dconf compile skel/.config/dconf/user dconf/db/local.d/
	mkdir -p $(DESTDIR)/usr/lib/parrot-skel/etc
	chmod 755 update-skel
	chown root:root -R skel dconf
	chmod 700 -R skel
