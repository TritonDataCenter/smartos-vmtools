NAME=sdc-vmtools

ifeq ($(VERSION), "")
	@echo "Use gmake"
endif

# Directories
SRC := $(shell pwd)

# Tools
MAKE = make
TAR = tar
UNAME := $(shell uname)
ifeq ($(UNAME), SunOS)
	MAKE = gmake
	TAR = gtar
	CC = gcc
endif

RESTDOWN = restdown

clean:
	@echo "Cleaning"
	rm -fr cache

all:
	bin/build-image

.PHONY: clean iso tar all
