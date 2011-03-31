all: battery

battery: Battery
	cp Battery battery

Battery: Battery.hs
	ghc --make -O2 -optl-static -optl-pthread Battery.hs

install: battery
	install battery $(PREFIX)/bin/

.PHONY: clean uninstall

uninstall: install
	rm $(PREFIX)/bin/battery

clean: battery
	rm battery
