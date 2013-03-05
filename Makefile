include build/framework.mk

OBJDIR = obj
BINDIR = bin

BIN	= serial.bin

SRC	= serial.c

OBJ	= $(addprefix $(OBJDIR)/,$(SRC:.c=.o))

.PHONY: all clean install

all: $(BINDIR)/$(BIN)
	@echo "Build finished"

# clean out the source tree ready to re-build
clean:
	-rm -rf $(OBJDIR) $(BINDIR)
	-rm -f build/deps.mk

# install software to board, remember to sync the file systems
install:
	@echo "Copying " $(BIN) "to the MBED file system"
	cp $(BIN).bin $(MBED_PATH)
	sync
	@echo "Now press the reset button on all MBED file systems"

# implicit rules & auto dependencies
include build/rules.mk
