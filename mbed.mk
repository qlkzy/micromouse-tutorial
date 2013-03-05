
# preprocessor options

INCLUDES += -I$(CMSIS)/include -I.
DEFINES += -D__RAM_MODE__=0

CPPFLAGS += $(INCLUDES) $(DEFINES)


# compiler options

CFLAGS += -mcpu=cortex-m3  -mthumb  -Wall  -O0  -mapcs-frame  -D__thumb2__=1           \
          -msoft-float  -gdwarf-2  -mno-sched-prolog  -fno-hosted  -mtune=cortex-m3    \
          -march=armv7-m  -mfix-cortex-m3-ldrd   -ffunction-sections  -fdata-sections  \


# linker options

LDSCRIPT = $(CMSIS)/lib/ldscript_rom_gnu.ld

# core libraries

GNU_VERSION		= 4.5.0
THUMB2GNULIB	= $(SOURCERY_PATH)/$(ARCH)/lib/$(GNU_VERSION)/thumb2
THUMB2GNULIB2	= $(SOURCERY_PATH)/$(ARCH)/lib/thumb2

CMSISOBJ = $(CMSIS)/lib/core_cm3.o \
           $(CMSIS)/lib/system_LPC17xx.o \
           $(CMSIS)/lib/startup_LPC17xx.o

LIBPATHS += -L$(THUMB2GNULIB) -L$(THUMB2GNULIB2) -L$(CMSIS)/lib 

MOPTS +=  -mcpu=cortex-m3 -mthumb -mthumb-interwork

LDFLAGS += -static $(MOPTS) $(LIBPATHS) \
           -Xlinker -Map=build/lpc1700.map -Xlinker -T $(LDSCRIPT)

LDLIBS += $(CMSISOBJ) -lc -lg -lstdc++ -lsupc++ -lgcc -lm -lDriversLPC17xxgnu
