#######################################
# debug
#######################################
ifeq (1,$(ENABLE_SEMIHOSTING))
debug:
	killall -q openocd ; openocd \
	-f interface/stlink-v2.cfg \
	-f target/stm32f1x.cfg \
	-c "init" \
	-c "arm semihosting enable" \
	sleep 1 &
	gdb-multiarch \
	--eval-command "tar ext :3333" \
	$(BUILD_APP_DIR)/$(TARGET).elf \
	--eval-command "load"
else
debug:
	gdb-multiarch \
	--eval-command "load" \
	-iex ' tar ext | openocd \
	-f interface/stlink-v2.cfg \
	-f target/stm32f1x.cfg \
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
