
zpass:
	lxsh -mo zpass src/main.sh

build: zpass

install: build
	cp zpass /usr/local/bin

uninstall:
	rm /usr/local/bin/zpass

clear:
	rm zpass
