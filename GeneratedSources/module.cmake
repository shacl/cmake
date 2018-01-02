# Please see `cmake/GeneratedSources/README.md` for documentation
cmake_minimum_required(VERSION 3.6)

get_property(
  GeneratedSources.cmake
  GLOBAL PROPERTY GeneratedSources SET)

if(NOT GeneratedSources.cmake)
  include(GeneratedSources/add_library.cmake)
  include(GeneratedSources/add_executable.cmake)
  include(GeneratedSources/target_sources.cmake)
endif()
