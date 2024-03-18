cmake_minimum_required (VERSION 3.20)

project(FOO)

set(target foo)

file(GLOB CPP_FILES ./src/*.cpp)

add_library(${target} STATIC ${CPP_FILES})
