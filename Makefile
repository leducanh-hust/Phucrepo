# Compiler and Flags
CXX = g++
CXXFLAGS = -std=c++17 -O2 -Wall -Wextra

# Directories
SRC_DIR = src
BUILD_DIR = build
KERNEL_DIR = kernels

# AMD APP SDK and OpenCV Paths
OPENCL_INC = "C:/OpenCL-SDK/include"
OPENCL_LIB = "C:/OpenCL-SDK/lib"
OPENCV_INC = "C:/ucrt64/include"
OPENCV_LIB = "C:/ucrt64/x64/mingw/lib"

# Linker Flags
LDFLAGS = -L$(OPENCL_LIB) -lOpenCL -L$(OPENCV_LIB) -lopencv_core4100 -lopencv_imgcodecs4100 -lopencv_highgui4100 -lopencv_imgproc4100

# Files
SRC = $(SRC_DIR)/main.cpp
EXE = $(BUILD_DIR)/median_filter.exe
INPUT_DIR = input
OUTPUT_DIR = output

# Pass Kernel File Path as a Macro
KERNEL_FILE = $(KERNEL_DIR)/median_filter.cl
CPPFLAGS = -DKERNEL_FILE_PATH=\"$(KERNEL_FILE)\"

# Default target
all: $(EXE)

# Build executable
$(EXE): $(SRC)
	@if not exist $(BUILD_DIR) mkdir $(BUILD_DIR)
	$(CXX) $(CXXFLAGS) $(CPPFLAGS) -I$(OPENCL_INC) -I$(OPENCV_INC) $(SRC) -o $@ $(LDFLAGS)
	@echo "Build successful!"

# Run Program
run: all
	@echo Running program...
	@$(BUILD_DIR)/median_filter.exe $(INPUT_DIR)/input.jpg $(OUTPUT_DIR)/output.jpg
	@echo Run successfully!

# Clean build files
clean:
	@if exist $(BUILD_DIR) rmdir /s /q $(BUILD_DIR)
