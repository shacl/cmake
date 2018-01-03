get_property(
  GeneratedSources.generated_sources_trap.cmake
  GLOBAL PROPERTY GeneratedSources.generated_sources_trap.cmake SET)

if(NOT GeneratedSources.generated_sources_trap.cmake)
  # -------------------------------------------------------------------------
  # This macro defines something analogous to a bash "trap" for CMake.
  #
  # The variable watch registers a callback function that is invoked each time a
  # parameter variable is accessed. As CMake completes parsing each
  # CMakeLists.txt file, CMake reads the `CMAKE_BACKWARDS_COMPATABILITY`
  # variable. Here we're using a variable watch on
  # `CMAKE_BACKWARDS_COMPATABILITY` to bootstrap trap-like behavior.
  #
  # In this case, we use this 'trap' to add generated files to targets as the
  # processing of the CMakeLists.txt of their respective directories of origin
  # are completed.
  #
  # This macro is not intended for general use, but is used by the functions
  # defined in this module.
  # -------------------------------------------------------------------------
  #
  macro(generated_sources_trap target)
    function(${target}_append_generated_files variable access)
      if(${access} STREQUAL UNKNOWN_READ_ACCESS OR ${access} STREQUAL READ_ACCESS)
        get_target_property(${target}.source_directory ${target} SOURCE_DIR)

        if(${CMAKE_CURRENT_SOURCE_DIR} STREQUAL ${${target}.source_directory}
            AND TARGET ${target}.generated_sources.PUBLIC)

          foreach(linkage PUBLIC PRIVATE INTERFACE)
            get_target_property(sources
              ${target}.generated_sources.${linkage}
              INTERFACE_SOURCES)

            foreach(source IN LISTS sources)
              set_source_files_properties(${source} PROPERTIES GENERATED TRUE)
            endforeach()

            if(sources)
              target_link_libraries(${target} ${linkage}
                $<BUILD_INTERFACE:${target}.generated_sources.${linkage}>)
            endif()

          endforeach()
        endif()
      endif()
    endfunction()

    variable_watch(CMAKE_BACKWARDS_COMPATIBILITY ${target}_append_generated_files)

  endmacro()

  set_property(GLOBAL PROPERTY GeneratedSources.generated_sources_trap.cmake "")
endif()
