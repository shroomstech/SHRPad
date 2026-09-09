cmake_minimum_required(VERSION 3.16)
project(shr_installer LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Enable automatic Qt features (crucial for Q_OBJECT classes)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTOUIC ON)
set(CMAKE_AUTORCC ON)

find_package(Qt6 REQUIRED COMPONENTS Core Gui Widgets)

set(PROJECT_SOURCES
    main.cpp
    MainWindow.cpp
    MainWindow.h
    resources.qrc
)

add_executable(shr_installer ${PROJECT_SOURCES})
target_link_libraries(shr_installer PRIVATE Qt6::Core Qt6::Gui Qt6::Widgets)