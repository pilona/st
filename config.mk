# st version
VERSION = $(shell git describe --long --tags --abbrev --dirty)

# Customize below to fit your system

# paths
PREFIX = $(HOME)/.local
MANPREFIX = $(PREFIX)/share/man

PKG_CONFIG = pkg-config

# includes and libs
INCS = `$(PKG_CONFIG) --cflags fontconfig` \
       `$(PKG_CONFIG) --cflags freetype2` \
       `$(PKG_CONFIG) --cflags harfbuzz`
LIBS = -lm -lrt -lX11 -lutil -lXft \
       `$(PKG_CONFIG) --libs fontconfig` \
       `$(PKG_CONFIG) --libs freetype2` \
       `$(PKG_CONFIG) --libs harfbuzz`

# flags
STCPPFLAGS = -DVERSION=\"$(VERSION)\" -D_XOPEN_SOURCE=600
STCPPFLAGS += -D_FORTIFY_SOURCE=2
STCFLAGS = $(INCS) $(STCPPFLAGS) $(CPPFLAGS) $(CFLAGS)
STCFLAGS += -pedantic -Wall -Wvariadic-macros
STCFLAGS += -fstack-protector-strong --param ssp-buffer-size=4 -fno-plt
STCFLAGS += -fPIE
STLDFLAGS = $(LIBS) $(LDFLAGS)
STLDFLAGS += -z relro -z now -pie

# OpenBSD:
#CPPFLAGS = -DVERSION=\"$(VERSION)\" -D_XOPEN_SOURCE=600 -D_BSD_SOURCE
#LIBS = -L$(X11LIB) -lm -lX11 -lutil -lXft \
#       `pkg-config --libs fontconfig` \
#       `pkg-config --libs freetype2`

# compiler and linker
# CC = c99
