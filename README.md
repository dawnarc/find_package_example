
This repo demonstrates `find_package` usage for CMake project buidling.

## Config Mode

Steps:

Address to my third library directory `config_mode/foo`:

	cd config_mode/foo

Create building config files：

	cmake . -B build

Execute building task:

	cmake --build build --config release

Install includes and libs to destination `D:/my_libs/FOO`:

	cmake --install build --config release --prefix D:/my_libs/FOO

output:
```
- Installing: D:/my_libs/FOO/lib/foo.lib
-- Installing: D:/my_libs/FOO/include/foo/foo.h
-- Installing: D:/my_libs/FOO/lib/cmake/FOO/FOOConfig.cmake
-- Installing: D:/my_libs/FOO/lib/cmake/FOO/FOOConfigVersion.cmake
-- Installing: D:/my_libs/FOO/lib/cmake/FOO/FOOTargets.cmake
-- Installing: D:/my_libs/FOO/lib/cmake/FOO/FOOTargets-release.cmake
```
It means installation has been done successfully.

Then address to my executable programm directory `config_mode/main`:

	cd ../main

Create building config files with the argument (FOO_DIR) to locate third party path:

	cmake . -B build -DFOO_DIR=D:/my_libs/FOO/lib/cmake/FOO

Start building:

	cmake --build build --config release

Execute program：

	call build\Release\main.exe

output:
```
I'm foo.
```

## Module Mode
