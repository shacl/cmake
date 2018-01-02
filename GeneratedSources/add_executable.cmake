include(GeneratedSources/generated_sources_trap.cmake)

get_property(
  GeneratedSources.add_executable.cmake
  GLOBAL PROPERTY GeneratedSources.add_executable.cmake SET)

if(NOT GeneratedSources.add_executable.cmake)

  function(add_library target)
    if(NOT TARGET ${target}.generated_sources.PUBLIC)
      _add_library(${target}.generated_sources.PUBLIC INTERFACE)
      _add_library(${target}.generated_sources.PRIVATE INTERFACE)
      _add_library(${target}.generated_sources.INTERFACE INTERFACE)
    endif()

    _add_executable(${ARGV} "")
    generated_sources_trap(${target})
  endfunction()

  set_property(GLOBAL PROPERTY GeneratedSources.add_executable.cmake "")
endif()
