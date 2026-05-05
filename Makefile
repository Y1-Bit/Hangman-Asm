ASM := nasm
CC := gcc

BUILD_DIR := build
SRC_DIR := src
TARGET := $(BUILD_DIR)/hangman-asm
OBJS := $(BUILD_DIR)/main.o $(BUILD_DIR)/display.o

.PHONY: all run clean

all: $(TARGET)

$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

$(BUILD_DIR)/%.o: $(SRC_DIR)/%.asm | $(BUILD_DIR)
	cd $(SRC_DIR) && $(ASM) -f elf64 $(notdir $<) -o ../$@

$(TARGET): $(OBJS)
	$(CC) $(OBJS) -o $(TARGET)

run: $(TARGET)
	./$(TARGET)

clean:
	rm -rf $(BUILD_DIR)
