cmake_minimum_required (VERSION 3.20)

project(main)

set(target main)

set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${CMAKE_SOURCE_DIR}/cmake/modules/")

find_package( FOO REQUIRED )
include_directories(${FOO_INCLUDE_DIR})

file(GLOB CPP_FILES ./src/*.cpp)

add_executable(${target} ${CPP_FILES})

target_link_libraries( ${target} ${FOO_LIBRARY} )