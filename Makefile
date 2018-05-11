all:

clean:

install:
	chown root:root parrot-core/*
	cp -rf parrot-core/* $(DESTDIR)/
	chmod 750 $(DESTDIR)/root/.bashrc
	mkdir -p $(DESTDIR)/etc/default/grub.d
	cp grub.default $(DESTDIR)/etc/default/grub.d/parrot.cfg
	chown root:root $(DESTDIR)/etc/default/grub.d/parrot.cfg
	chmod 644 $(DESTDIR)/etc/default/grub.d/parrot.cfg
