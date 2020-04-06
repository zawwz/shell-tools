IDIR=include
SRCDIR=src
ODIR=obj
BINDIR=.

NAME = hello

LDFLAGS =

CC=gcc
CXXFLAGS= -I$(IDIR) -Wall -pedantic -std=c18 -O2
ifeq	 ($(DEBUG),true)
	CXXFLAGS += -g
endif

$(shell mkdir -p $(ODIR))
$(shell mkdir -p $(BINDIR))

# automatically finds .h
DEPS = $(shell find $(IDIR) -type f -regex '.*\.h')
# automatically finds .c and makes the corresponding .o rule
OBJ = $(shell find $(SRCDIR) -type f -regex '.*\.c' | sed 's|\.c$|.o|g;s|$(SRCDIR)/|$(ODIR)/|g')

$(ODIR)/%.o: $(SRCDIR)/%.c $(DEPS)
	$(CC) $(CXXFLAGS) -c -o $@ $<

$(BINDIR)/$(NAME): $(OBJ) $(DEPS)
	$(CC) $(CXXFLAGS) -o $@ $^ $(LDFLAGS)

test: $(BINDIR)/$(NAME)
	$(BINDIR)/$(NAME)

clean:
	rm $(ODIR)/*.o

clear:
	rm $(BINDIR)/$(NAME)
