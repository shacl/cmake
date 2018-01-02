include(GeneratedSources/generated_sources_trap.cmake)

get_property(
  GeneratedSources.add_library.cmake
  GLOBAL PROPERTY GeneratedSources.add_library.cmake SET)

if(NOT GeneratedSources.add_library.cmake)

  function(add_library target linkage)
    if(linkage STREQUAL "ALIAS")
      _add_library(${ARGV})
      return()
    endif()

    if(NOT TARGET ${target}.generated_sources.PUBLIC)
      _add_library(${target}.generated_sources.PUBLIC INTERFACE)
      _add_library(${target}.generated_sources.PRIVATE INTERFACE)
      _add_library(${target}.generated_sources.INTERFACE INTERFACE)
    endif()

    _add_library(${ARGV} "")
    generated_sources_trap(${target})
  endfunction()

  set_property(GLOBAL PROPERTY GeneratedSources.add_library.cmake "")
endif()
