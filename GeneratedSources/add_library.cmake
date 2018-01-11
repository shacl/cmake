include(GeneratedSources/generated_sources_trap)

# Here we're using the existance of global properties to act as something
# analoguous to C/C++ header guards to ensure the contents of this file are not
# redundantly defined.

get_property(
  GeneratedSources.add_library.cmake
  GLOBAL PROPERTY GeneratedSources.add_library.cmake SET)

if(NOT GeneratedSources.add_library.cmake)

  backup(add_library)

  function(add_library target keyword)
    if(keyword STREQUAL "ALIAS")
      previous_add_library(${ARGV})
      return()
    endif()
    stripped(${target})
    set(${stripped_target_name}.source_directory "${CMAKE_CURRENT_SOURCE_DIR}"
      CACHE INTERNAL
      "Cache variable because source directory isnt available on some targets")

    previous_add_library(${stripped_target_name}.generated_sources.PUBLIC INTERFACE)
    previous_add_library(${stripped_target_name}.generated_sources.PRIVATE INTERFACE)
    previous_add_library(${stripped_target_name}.generated_sources.INTERFACE INTERFACE)
    previous_add_library(${ARGV})
    generated_sources_trap(${target})
  endfunction()

  set_property(
    GLOBAL PROPERTY GeneratedSources.add_library.cmake
    "This is a header guard")
endif()
