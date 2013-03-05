USER := $(shell whoami)

# setup conditional paths for CS dept
# all variables set in here can be overidden from environment
include host.mk

# setup paths to tools
include tools.mk

# toolchain flags for the mbed target
include mbed.mk


OBJDIR = obj

# project variables
BIN = bin/serial
SRC = serial.o 
OBJ = $(addprefix $(OBJDIR)/,$(SRC:.c=.o))

# rules

.PHONY: all clean

all: serial
	@echo "Build finished"

# changes to the makefile should trigger a full rebuild; we could hash
# the makefile/options, but it's not worth it on a project this size
$(OBJ): Makefile

$(BIN).elf: $(OBJ)
	$(CC) $(LDFLAGS) -o $(BIN) $(OBJ) -Wl,--start-group $(LDLIBS) -Wl,--end-group $(LDLIBS)
	$(OBJCOPY) -I elf32-little -O binary $(BIN) $(BIN).bin

%.bin: %.elf
	$(OBJCOPY) -I elf32-little -O binary $< $@

$(OBJDIR)/%.o: 

# clean out the source tree ready to re-build
clean:
	-rm -f bin/*
	-rm -f obj/*

# install software to board, remember to sync the file systems
install:
	@echo "Copying " $(BIN) "to the MBED file system"
	cp $(BIN).bin $(MBED_PATH)
	sync
	@echo "Now press the reset button on all MBED file systems"


deps.mk: 
	$(CC) -MM $(SRC) | perl -pe "s/^(\S+.o)/$(OBJDIR)\/\1/;" > deps.mk

-include deps.mk
