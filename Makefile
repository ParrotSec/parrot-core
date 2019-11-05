all:

clean:

install:
	chown root:root parrot-core/*
	cp -rf parrot-core/* $(DESTDIR)/
	chmod 750 $(DESTDIR)/root/.bashrc
	mkdir -p $(DESTDIR)/etc/default/grub.d
	mkdir -p $(DESTDIR)/lib/systemd/{system/postgresql@.service.d,system-preset}
	mkdir -p $(DESTDIR)/sandbox
	cp grub.default $(DESTDIR)/etc/default/grub.d/parrot.cfg
	cp -r systemd/parrot_postgresql.conf $(DESTDIR)/lib/systemd/system/postgresql@.service.d/
	cp systemd/80-parrot.preset $(DESTDIR)/lib/systemd/system-preset/
	chown root:root $(DESTDIR)/etc/default/grub.d/parrot.cfg
	chown root:root $(DESTDIR)/sandbox
	chown -R root:root $(DESTDIR)/lib/
	chmod 644 $(DESTDIR)/etc/default/grub.d/parrot.cfg
	chmod 755 $(DESTDIR)/sandbox
	chmod 644 $(DESTDIR)/lib/systemd/system/postgresql@.service.d/*
	chmod 644 $(DESTDIR)/lib/systemd/system-preset/*
	ifeq ($(DEB_TARGET_ARCH), amd64)
		GOARCH=amd64
	endif
	ifeq ($(DEB_TARGET_ARCH), i386)
		GOARCH=386
	endif
	ifeq ($(DEB_TARGET_ARCH), armhf)
		GOARCH=arm
	endif
	ifeq ($(DEB_TARGET_ARCH), armel)
		GOARCH=arm
	endif
	ifeq ($(DEB_TARGET_ARCH), arm64)
		GOARCH=arm64
	endif
	go build -o $(DESTDIR)/usr/bin/update-sandbox-launchers update-sandbox-launchers.go
	strip $(DESTDIR)/usr/bin/update-sandbox-launchers
	
