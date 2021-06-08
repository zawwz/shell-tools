## CONFIG ##

IDIR=include
SRCDIR=src
ODIR=obj
BINDIR=.

# binary name, default name of dir
NAME = $(shell readlink -f . | xargs basename)

# global links
LDFLAGS =

# compiler
CC=gcc
# compiler flags
CXXFLAGS= -I$(IDIR) -Wall -pedantic -std=c18
ifeq	($(DEBUG),true)
	# debugging flags
	CXXFLAGS += -g
	RODIR = $(ODIR)/debug
else
	# release flags
	CXXFLAGS += -O2
	RODIR = $(ODIR)/release
endif
ifeq	($(STATIC),true)
	# static links
	LDFLAGS +=
else
	# dynamic links
	LDFLAGS +=
endif

## END CONFIG ##

$(shell mkdir -p $(RODIR))
$(shell mkdir -p $(BINDIR))

# automatically find .h
DEPS = $(shell find $(IDIR) -type f -regex '.*\.h')
# automatically find .c and make the corresponding .o rule
OBJ = $(shell find $(SRCDIR) -type f -regex '.*\.c' | sed 's|\.c|.o|g;s|^$(SRCDIR)/|$(RODIR)/|g')

build: $(BINDIR)/$(NAME)

$(RODIR)/%.o: $(SRCDIR)/%.c $(DEPS)
	$(CC) $(CXXFLAGS) -c -o $@ $<

$(BINDIR)/$(NAME): $(OBJ)
	$(CC) $(CXXFLAGS) -o $@ $^ $(LDFLAGS)

test: $(BINDIR)/$(NAME)
	$(BINDIR)/$(NAME)

clean:
	rm $(ODIR)/*/*.o

clear:
	rm $(BINDIR)/$(NAME)
