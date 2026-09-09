BUILD_DIR = build
TARGET = shr_installer
INSTALL_DIR = $(HOME)/.local/bin
APP_DIR = $(HOME)/.local/share/applications

all: build

$(BUILD_DIR)/Makefile:
	mkdir -p $(BUILD_DIR)
	cd $(BUILD_DIR) && cmake ..

build: $(BUILD_DIR)/Makefile
	cd $(BUILD_DIR) && cmake --build .

clean:
	rm -rf $(BUILD_DIR)

rebuild: clean all

run: build
	./$(BUILD_DIR)/$(TARGET)

# Verify that the executable was built successfully
test: build
	@echo "Running verification test..."
	@if [ -f $(BUILD_DIR)/$(TARGET) ]; then \
		echo "SUCCESS: Executable exists and is ready."; \
	else \
		echo "FAILURE: Executable not found!"; exit 1; \
	fi

# Install binary and create a Desktop Entry for the Application Launcher
install: build
	@echo "Installing SHR Notepad..."
	mkdir -p $(INSTALL_DIR)
	mkdir -p $(APP_DIR)
	
	# Copy binary to local bin
	cp $(BUILD_DIR)/$(TARGET) $(INSTALL_DIR)/shr_notepad
	
	# Generate the .desktop launcher file
	@echo "[Desktop Entry]" > $(APP_DIR)/shr_notepad.desktop
	@echo "Type=Application" >> $(APP_DIR)/shr_notepad.desktop
	@echo "Name=SHRPad" >> $(APP_DIR)/shr_notepad.desktop
	@echo "Comment=A minimalist Qt6 text editor" >> $(APP_DIR)/shr_notepad.desktop
	@echo "Exec=$(INSTALL_DIR)/shr_notepad" >> $(APP_DIR)/shr_notepad.desktop
	@echo "Icon=$(shell pwd)/resources/icon.png" >> $(APP_DIR)/shr_notepad.desktop
	@echo "Categories=Utility;TextEditor;" >> $(APP_DIR)/shr_notepad.desktop
	@echo "Terminal=false" >> $(APP_DIR)/shr_notepad.desktop
	
	# Refresh desktop database so the launcher picks it up immediately
	@update-desktop-database $(APP_DIR) 2>/dev/null || true
	@echo "Installed successfully! You can now search for 'SHR Notepad' in your Application Launcher."

uninstall:
	@echo "Uninstalling SHR Notepad..."
	rm -f $(INSTALL_DIR)/shr_notepad
	rm -f $(APP_DIR)/shr_notepad.desktop
	@update-desktop-database $(APP_DIR) 2>/dev/null || true
	@echo "Uninstalled successfully."

# Developing Preview or Custom Modding Option
debug: clean all run
