INSTDIR = /usr/bin

LIBSRC =  $(shell echo src/lib/)
LIBFLAGS = -c -fPIC
OBJECTFLAGS = -shared -fPIC -o

# program - för att bygga endast programmet
program:
	$(CC) -Wall -I /usr/include/libelektro/ -o elektrotest src/elektrotest.c -lcomponent -lpower -lresistance

# all - för att kompilera biblioteken, bygga en ekekverbar fil "electrotest" och länka den till biblioteken
all: program

# clean - för att bort samtliga objektfiler
clean: distclean

# install - för att kopiera körbara filer och bibliotek till rätt katalog samt länka dem
install: program
	install -d '$(INSTDIR)'
	install -t '$(INSTDIR)' elektrotest

# distclean - återställ katalogen till dess ursprungliga form
distclean:
	-rm elektrotest

# uninstall - för att ta bort det som gjordes av "install"
uninstall:
	-rm $(INSTDIR)/elektrotest
