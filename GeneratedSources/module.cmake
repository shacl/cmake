# Please see `cmake/GeneratedSources/README.md` for documentation
cmake_minimum_required(VERSION 3.6)

# Here we're using the existance of global properties to act as something
# analoguous to C/C++ header guards to ensure the contents of this file are not
# redunantly defined.

get_property(
  GeneratedSources.module.cmake
  GLOBAL PROPERTY GeneratedSources SET)

if(NOT GeneratedSources.module.cmake)
  include(GeneratedSources/add_library.cmake)
  include(GeneratedSources/add_executable.cmake)
  include(GeneratedSources/target_sources.cmake)
endif()
