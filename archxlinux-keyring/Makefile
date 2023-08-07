V=20210107

PREFIX = /usr/local

install:
	install -dm755 $(DESTDIR)$(PREFIX)/share/pacman/keyrings/
	install -m0644 archxlinux.gpg $(DESTDIR)$(PREFIX)/share/pacman/keyrings/

	install -m0644 archxlinux-revoked $(DESTDIR)$(PREFIX)/share/pacman/keyrings/
	install -m0644 archxlinux-trusted $(DESTDIR)$(PREFIX)/share/pacman/keyrings/

uninstall:
	rm -f $(DESTDIR)$(PREFIX)/share/pacman/keyrings/archxlinux.gpg}
	rmdir -p --ignore-fail-on-non-empty $(DESTDIR)$(PREFIX)/share/pacman/keyrings/
