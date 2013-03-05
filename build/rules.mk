# ensure that temp directories exist
$(OBJ): $(OBJDIR) $(BINDIR)

$(OBJDIR):
	mkdir -p $@
$(BINDIR):
	mkdir -p $@


# force recompilation when makefiles changes
$(OBJ): Makefile build/*.mk

# implicit rules
%.elf: $(OBJ)
	$(CC) -o $@ $(OBJ) $(LDFLAGS) $(LDLIBS)
%.bin: %.elf
	$(OBJCOPY) -I elf32-little -O binary $< $@

$(OBJDIR)/%.o: %.c
	$(COMPILE.c) -o $@ $<

# automatic dependency generation
build/deps.mk:
	$(CC) $(CPPFLAGS) -MM $(SRC) | perl -pe "s/^(\S+.o)/$(OBJDIR)\/\1/;" > build/deps.mk

-include build/deps.mk

