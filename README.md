
# CMake find_package Usage Example

This repo demonstrates `find_package` usage for CMake project buidling.

There're two directories:
+ `config_mode`: the example to demonstrate Config Mode (`find_package( FOO CONFIG REQUIRED )`)
+ `module_mode`: the example to demonstrate Module Mode (`find_package( FOO REQUIRED )`)

> [!TIP]
> Config Mode vs Module Mode  
> Config Mode is is suitable for developing third-party libraries published to the Internet.  
> Module Mode is more convenient to configure private team projects.

## Config Mode

First, let's take a look at [CMakeLists.txt](config_mode/foo/CMakeLists.txt), it's a little complicated, but that's the minimum required configuration to run installation (`--install build`).  
As a result you can add dependency with just one line of code:

    find_package( FOO CONFIG REQUIRED )

Steps:

Locate to third library directory `config_mode/foo`:

    cd config_mode/foo

Create building config files：

    cmake . -B build

Execute building task:

    cmake --build build --config release

Install includes and libs to destination `D:/my_libs/FOO`:

    cmake --install build --config release --prefix D:/my_libs/FOO

output:
```
-- Installing: D:/my_libs/FOO/lib/foo.lib
-- Installing: D:/my_libs/FOO/include/foo/foo.h
-- Installing: D:/my_libs/FOO/lib/cmake/FOO/FOOConfig.cmake
-- Installing: D:/my_libs/FOO/lib/cmake/FOO/FOOConfigVersion.cmake
-- Installing: D:/my_libs/FOO/lib/cmake/FOO/FOOTargets.cmake
-- Installing: D:/my_libs/FOO/lib/cmake/FOO/FOOTargets-release.cmake
```
It means installation has been done successfully.

Then Locate to executable programm directory `config_mode/main`:

    cd ../main

Create building config files with the argument (FOO_DIR) to locate third party path:

    cmake . -B build -DFOO_DIR=D:/my_libs/FOO/lib/cmake/FOO

> [!IMPORTANT]  
> If main project adds dependency using `add_subdirectory(foo)`, thus you can run command without `-DFOO_DIR`.

Start building:

    cmake --build build --config release

Execute program：

    call build\Release\main.exe

output:
```
I'm foo.
```

## Module Mode

Steps:

Locate to third library directory `module_mode/foo`:

    cd module_mode/foo

Create building config files：

    cmake . -B build

Execute building task:

    cmake --build build --config release

Then copy header and lib into you customized third party path manually, e.g. `C:/Program Files (x86)/FOO`.  
directory structure:
```
C:/Program Files (x86)/FOO
                        |
                        + include
                        |    |
                        |    + foo
                        |       |
                        |       + foo.h
                        + lib
                            |
                            + foo.lib
```

> [!WARNING]  
> Because Module mode doesn't need installation script in CMakeLists.txt, so you must copy files by hand.

Then Locate to file [FindFOO.cmake](module_mode/main/cmake/modules/FindFOO.cmake), this's an example to config third party path for `CMAKE_MODULE_PATH`.  
You must create `FindXXX.cmake` file manually for you every third party library.

Take a look at [CMakeLists.txt](module_mode/main/CMakeLists.txt):
+ Add path to search FindFOO.cmake:

        set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${CMAKE_SOURCE_DIR}/cmake/modules/")

+ Then use Module Mode to find package:

        find_package( FOO REQUIRED )

+ Then include headers and link libs:

        include_directories(${FOO_INCLUDE_DIR})
        target_link_libraries( ${target} ${FOO_LIBRARY} )

Now you can build main project:

    cmake . -B build
    cmake --build build --config release

Final test:

    call build\Release\main.exe

output:
```
I'm foo.
```

## References

CMake: config mode of find_package command (examples)  
https://github.com/forexample/package-example

创建自己的xxxConfig.cmake，用于第三方使用  
https://blog.csdn.net/xiaoxiaozengz/article/details/127399274

Code repository of all OpenGL chapters from the book and its accompanying  
https://github.com/JoeyDeVries/LearnOpenGL