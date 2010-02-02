all: battery

battery: battery.cpp

install: battery
	install battery $(HOME)/bin/
