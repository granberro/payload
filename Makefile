
CFLAGS = -Wall -O3



PPU_CC = ppu-gcc
PPU_OBJCOPY = ppu-objcopy
REMOVE = rm -f
REMOVEDIR = rm -rf

OBJDIR = .

PLOBJDIR = .
DATA = ../data

PLSRC = payload_groove_hermes.S

PLOBJ = $(PLSRC:%.S=$(PLOBJDIR)/%.o) 
PLBIN = $(PLOBJ:%.o=$(PLOBJDIR)/%.bin)

all: deps payloads

deps:
	@mkdir -p .depp

payloads : $(PLOBJ) $(PLBIN)

port1_config_descriptor.o: $(wildcard payload_*.S)

%.o : %.S
	$(PPU_CC) -c $< -o $@

%.bin : %.o
	$(PPU_OBJCOPY) -O binary $< $@

copy: 
	@cp $(PLOBJDIR)/payload_groove_hermes.bin $(DATA)
	
# Target: clean project.
clean:
	$(REMOVE) $(PLSRC:%.S=$(PLOBJDIR)/%.o)
	$(REMOVE) $(PLOBJ:%.o=$(PLOBJDIR)/%.bin)

.PHONY: all deps payloads clean
