CC?=		cc
CFLAGS+=	-O2 -Wall -Wunused \
		-DADB_HOST=1 -D_XOPEN_SOURCE -D_GNU_SOURCE -DHAVE_FORKEXEC \
		-I. -Iinclude -I/usr/local/include/libusb-1.0 \
		-I/usr/local/include
CFLAGS+=	-g

PREFIX=		/usr/local
BINDIR=		$(DESTDIR)$(PREFIX)/bin

INSTALL_PROGRAM=install -s

PROG	=	adb
OBJS	=	adb.o \
		console.o \
		transport.o \
		transport_local.o \
		transport_usb.o \
		commandline.o \
		adb_client.o \
		sockets.o \
		services.o \
		file_sync_client.o \
		get_my_path_openbsd.o \
		usb_libusb.o \
		fdevent.o \
		utils.o \
		usb_vendors.o \
		libcutils/socket_network_client.o \
		libcutils/socket_local_client.o \
		libcutils/socket_local_server.o \
		libcutils/socket_inaddr_any_server.o \
		libcutils/socket_loopback_client.o \
		libcutils/socket_loopback_server.o

LDPATH+=	-L/usr/local/lib
LIBS=		-lpthread -lusb-1.0

all: $(PROG)

$(PROG): $(OBJS)
	$(CC) $(OBJS) $(LDPATH) $(LIBS) -o $@

$(OBJS): *.o: *.c
	$(CC) $(CFLAGS) $(INCLUDES) -c $< -o $@

install: all
	$(INSTALL_PROGRAM) $(PROG) $(BINDIR)

clean:
	rm -f $(PROG) $(OBJS) 

.PHONY: all install clean
