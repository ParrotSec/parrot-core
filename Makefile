all:

clean:

install:
	chown root:root parrot-core/*
	cp -rf parrot-core/* $(DESTDIR)/
	chmod 750 $(DESTDIR)/root/.bashrc
	mkdir -p $(DESTDIR)/etc/default/grub.d
	mkdir -p $(DESTDIR)/sandbox
	cp grub.default $(DESTDIR)/etc/default/grub.d/parrot.cfg
	chown root:root $(DESTDIR)/etc/default/grub.d/parrot.cfg
	chown root:root /sandbox
	chmod 644 $(DESTDIR)/etc/default/grub.d/parrot.cfg
	chmod 755 /sandbox
	go build update-sandbox-launchers.go -o $(DESTDIR)/usr/bin/update-sandbox-launchers
	strip $(DESTDIR)/usr/bin/update-sandbox-launchers
	
