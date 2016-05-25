DST_DIR := nimbus
SOURCES := lib.sh


all: copy

copy: clean
	@mkdir -p $(DST_DIR)
	@cp $(SOURCES) $(DST_DIR)/$(SOURCES)

clean:
	@rm -rf $(DST_DIR)
