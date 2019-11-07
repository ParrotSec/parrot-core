GO_BUILD = go build
GO_FLAGS = -v

REPO = $(shell pwd)
BUILDDIR = $(REPO)/build
GO_BUILD = go build
GO_FLAGS = -v
ARCH := $(shell go version|awk -F'/' '{print $$NF}')

ifeq ($(ARCH), amd64)
	ARCH = x86_64
endif

all:

clean:

install:
	chown root:root parrot-core/*
	cp -rf parrot-core/* $(DESTDIR)/
	chmod 750 $(DESTDIR)/root/.bashrc
	mkdir -p $(DESTDIR)/etc/default/grub.d
	mkdir -p $(DESTDIR)/lib/systemd/system/postgresql@.service.d
	mkdir -p $(DESTDIR)/lib/systemd/system-preset
	mkdir -p $(DESTDIR)/sandbox
	cp grub.default $(DESTDIR)/etc/default/grub.d/parrot.cfg
	cp -r systemd/parrot_postgresql.conf $(DESTDIR)/lib/systemd/system/postgresql@.service.d/
	cp systemd/80-parrot.preset $(DESTDIR)/lib/systemd/system-preset/
	chown root:root $(DESTDIR)/etc/default/grub.d/parrot.cfg
	chown root:root $(DESTDIR)/sandbox
	chown -R root:root $(DESTDIR)/lib/
	chmod 644 $(DESTDIR)/etc/default/grub.d/parrot.cfg
	chmod 644 $(DESTDIR)/etc/used/rules.d/*
	chmod 755 $(DESTDIR)/sandbox
	chmod 644 $(DESTDIR)/lib/systemd/system/postgresql@.service.d/*
	chmod 644 $(DESTDIR)/lib/systemd/system-preset/*
	mkdir -p $(BUILDDIR)
	GOPATH=$(BUILDDIR) GOCACHE=$(BUILDDIR) $(GO_BUILD) $(GO_FLAGS) -o $(DESTDIR)/usr/bin/update-sandbox-launchers update-sandbox-launchers.go
	strip $(DESTDIR)/usr/bin/update-sandbox-launchers
