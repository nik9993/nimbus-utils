DST_DIR := nimbus
SOURCES := lib.sh

DST := nimbus-utils

all: copy

copy:
	@mkdir -p $(DST_DIR)
	@cp $(SOURCES) $(DST_DIR)/$(DST)

clean:
	@rm -rf $(DST_DIR)
