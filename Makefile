INSTDIR = /usr/bin

LIBSRC =  $(shell echo src/lib/)
LIBFLAGS = -c -fPIC
OBJECTFLAGS = -shared -fPIC -o

# program - för att bygga endast programmet
program:
	$(CC) -Wall -I /usr/include/libelektro/ -o electrotest src/electrotest.c -lcomponent -lpower -lresistance

# all - för att kompilera biblioteken, bygga en ekekverbar fil "electrotest" och länka den till biblioteken
all: program

# clean - för att bort samtliga objektfiler
clean: distclean

# install - för att kopiera körbara filer och bibliotek till rätt katalog samt länka dem
install: program
	install -d '$(INSTDIR)'
	install -t '$(INSTDIR)' electrotest

# distclean - återställ katalogen till dess ursprungliga form
distclean:
	-rm electrotest

# uninstall - för att ta bort det som gjordes av "install"
uninstall:
	-rm $(INSTDIR)/electrotest
