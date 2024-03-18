
set( _foo_HEADER_SEARCH_DIRS
"/usr/include"
"/usr/local/include"
"${CMAKE_SOURCE_DIR}/includes"
"C:/Program Files (x86)/FOO/include" )

set( _foo_LIB_SEARCH_DIRS
"/usr/lib"
"/usr/local/lib"
"${CMAKE_SOURCE_DIR}/lib"
"C:/Program Files (x86)/FOO/lib" )

# Check environment for root search directory
set( _foo_ENV_ROOT $ENV{FOO_ROOT} )
if( NOT FOO_ROOT AND _foo_ENV_ROOT )
  set(FOO_ROOT ${_foo_ENV_ROOT} )
endif()

# Put user specified location at beginning of search
if( FOO_ROOT )
  list( INSERT _foo_HEADER_SEARCH_DIRS 0 "${FOO_ROOT}/include" )
  list( INSERT _foo_LIB_SEARCH_DIRS 0 "${FOO_ROOT}/lib" )
endif()

# Search for the header
FIND_PATH(FOO_INCLUDE_DIR "foo/foo.h"
PATHS ${_foo_HEADER_SEARCH_DIRS} )

# Search for the library
FIND_LIBRARY(FOO_LIBRARY NAMES foo
PATHS ${_foo_LIB_SEARCH_DIRS} )
INCLUDE(FindPackageHandleStandardArgs)
FIND_PACKAGE_HANDLE_STANDARD_ARGS(FOO DEFAULT_MSG
FOO_LIBRARY FOO_INCLUDE_DIR)
