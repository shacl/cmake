include(GeneratedSources/generated_sources_trap.cmake)

# Here we're using the existance of global properties to act as something
# analoguous to C/C++ header guards to ensure the contents of this file are not
# redundantly defined.

get_property(
  GeneratedSources.add_executable.cmake
  GLOBAL PROPERTY GeneratedSources.add_executable.cmake SET)

if(NOT GeneratedSources.add_executable.cmake)

  function(add_executable target)
    _add_library(${target}.generated_sources.PUBLIC INTERFACE)
    _add_library(${target}.generated_sources.PRIVATE INTERFACE)
    _add_library(${target}.generated_sources.INTERFACE INTERFACE)
    _add_executable(${ARGV} "")
    generated_sources_trap(${target})
  endfunction()

  set_property(
    GLOBAL PROPERTY GeneratedSources.add_executable.cmake
    "This is a header guard")
endif()
