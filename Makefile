CC      ?= gcc
CFLAGS  ?= -O2 -Wall -Wextra
CFLAGS  += -fPIC -fvisibility=hidden
LDFLAGS += -shared -Wl,--no-undefined

PREFIX  ?= /usr/local
LIBDIR  ?= $(PREFIX)/lib

TARGET  := libksm.so

.PHONY: all install clean

all: $(TARGET)

$(TARGET): ksm.c
	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $< $(LDLIBS)

install: $(TARGET)
	install -D -m 0755 $(TARGET) $(DESTDIR)$(LIBDIR)/$(TARGET)

clean:
	rm -f $(TARGET)
