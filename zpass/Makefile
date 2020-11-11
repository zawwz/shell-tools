
var_exclude = ZPASS_.* XDG_.* REMOTE_.* DISPLAY CONFIGFILE TMPDIR

zpass: src/*
	lxsh -o zpass -m --minimize-var --exclude-var "$(var_exclude)" --minimize-fct --remove-unused src/main.sh

build: zpass

install: build
	cp zpass /usr/local/bin

uninstall:
	rm /usr/local/bin/zpass

clear:
	rm zpass
