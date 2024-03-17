cmake_minimum_required (VERSION 3.20)

project(main)

set(target main)

find_package( FOO CONFIG REQUIRED )

file(GLOB CPP_FILES ./src/*.cpp)

add_executable(${target} ${CPP_FILES})

target_link_libraries( ${target} FOO::foo )