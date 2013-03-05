USER := $(shell whoami)

# host-specific paths
# everything in here can be overriden by the environment
include build/host.mk

# configure $(CC) etc for cross-compilation
include build/tools.mk

# mbed-specific flags
include build/mbed.mk

