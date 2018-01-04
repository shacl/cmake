include(GeneratedSources/generated_sources_trap)

# Here we're using the existance of global properties to act as something
# analoguous to C/C++ header guards to ensure the contents of this file are not
# redundantly defined.

get_property(
  GeneratedSources.add_library.cmake
  GLOBAL PROPERTY GeneratedSources.add_library.cmake SET)

if(NOT GeneratedSources.add_library.cmake)

  function(add_library target linkage)
    if(linkage STREQUAL "ALIAS")
      _add_library(${ARGV})
      return()
    endif()

    _add_library(${target}.generated_sources.PUBLIC INTERFACE)
    _add_library(${target}.generated_sources.PRIVATE INTERFACE)
    _add_library(${target}.generated_sources.INTERFACE INTERFACE)
    _add_library(${ARGV} "")
    generated_sources_trap(${target})
  endfunction()

  set_property(
    GLOBAL PROPERTY GeneratedSources.add_library.cmake
    "This is a header guard")
endif()
