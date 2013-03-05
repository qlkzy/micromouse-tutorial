
USER:=$(shell whoami)

-include host.mk

-include tools.mk

-include mbed.mk

EXECNAME	= bin/serial

OBJ		= serial.o 

all: 	serial
	@echo "Build finished"


serial: $(OBJ)
	$(CC) -o $(EXECNAME) $(OBJ) $(LDFLAGS) $(LDLIBS)
	$(OBJCOPY) -I elf32-little -O binary $(EXECNAME) $(EXECNAME).bin

# clean out the source tree ready to re-build
clean:
	rm -f `find . | grep \~`
	rm -f *.swp *.o */*.o */*/*.o  *.log
	rm -f *.d */*.d *.srec */*.a bin/*.map
	rm -f *.elf *.wrn bin/*.bin log *.hex
	rm -f $(EXECNAME)
# install software to board, remember to sync the file systems
install:
	@echo "Copying " $(EXECNAME) "to the MBED file system"
	cp $(EXECNAME).bin /run/media/$(USER)/MBED &
	sync
	@echo "Now press the reset button on all MBED file systems"

