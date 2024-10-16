#######################################
# debug
#######################################

#######################################
# Generate OpenOCD config file
OPENOCD_SCRIPT    = 'sc_openocd.cfg'
GDB_PORT          = '3333'
OPENOCD_INTERFACE = 'interface/stlink-v2.cfg'
OPENOCD_TARGET    = 'target/stm32f4x.cfg'
ADAPTER_SPEED     = 'adapter speed 1800'
#######################################

#######################################
ifeq (1,$(ENABLE_SEMIHOSTING))
debug:
	$(shell  echo 'gdb_port $(GDB_PORT)' > $(OPENOCD_SCRIPT))
	$(shell  echo 'source [find $(OPENOCD_INTERFACE)]' >> $(OPENOCD_SCRIPT))
	$(shell  echo 'source [find $(OPENOCD_TARGET)]' >> $(OPENOCD_SCRIPT))
	$(shell  echo 'init' >> $(OPENOCD_SCRIPT))
	$(shell  echo 'arm semihosting enable' >> $(OPENOCD_SCRIPT))
	$(shell  echo $(ADAPTER_SPEED) >> $(OPENOCD_SCRIPT))
	sh tmux.run $(BUILD_APP_DIR)/$(TARGET).elf
else
debug:
	gdb-multiarch \
	--eval-command "load" \
	-iex ' tar ext | openocd \
	-f $(OPENOCD_INTERFACE) \
	-f $(OPENOCD_TARGET) \
	-c "adapter_khz 1800" \
	-c "interface hla" \
	-c "gdb_port pipe" ' \
	-iex "monitor halt" \
	$(BUILD_APP_DIR)/$(TARGET).elf
endif

#######################################
# dependencies
#######################################
-include $(wildcard $(BUILD_DIR)/*.d)

# *** EOF ***
