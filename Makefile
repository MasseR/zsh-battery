PREFIX=$(HOME)

all: battery

battery: battery.cpp

install: battery
	install battery $(PREFIX)/bin/

.PHONY: clean uninstall

uninstall: install
	rm $(PREFIX)/bin/battery

clean: battery
	rm battery
