# Please see `cmake/GeneratedSources/README.md` for documentation
cmake_minimum_required(VERSION 3.6)

# Here we're using the existance of global properties to act as something
# analoguous to C/C++ header guards to ensure the contents of this file are not
# redundantly defined.

get_property(
  GeneratedSources.cmake
  GLOBAL PROPERTY GeneratedSources.cmake SET)

if(NOT GeneratedSources.cmake)
  include(GeneratedSources/add_library.cmake)
  include(GeneratedSources/add_executable.cmake)
  include(GeneratedSources/target_sources.cmake)

  set_property(
    GLOBAL PROPERTY GeneratedSources.cmake
    "This is a header guard")
endif()
