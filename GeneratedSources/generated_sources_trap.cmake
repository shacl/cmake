# Here we're using the existance of global properties to act as something
# analoguous to C/C++ header guards to ensure the contents of this file are not
# redundantly defined.

get_property(
  GeneratedSources.generated_sources_trap.cmake
  GLOBAL PROPERTY GeneratedSources.generated_sources_trap.cmake SET)

if(NOT GeneratedSources.generated_sources_trap.cmake)
  # -------------------------------------------------------------------------
  # Firstly, I apologize for the complexity of this macro. It's an example of
  # doing terrible things with CMake scripting. I was unable to find a more
  # idiomatic way of accomplishing what was required for the task at hand.
  #
  # This macro defines something analogous to a bash "trap" for CMake.
  #
  # The `variable_watch` function registers a callback function that is invoked
  # each time a parameter variable is accessed. As CMake completes parsing each
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
    stripped(${target})

    function(${stripped_target_name}_append_generated_files variable access)
      if(${access} STREQUAL UNKNOWN_READ_ACCESS OR ${access} STREQUAL READ_ACCESS)
        if(NOT TARGET ${stripped_target_name}.generated_sources.PUBLIC)
          return()
        endif()

        if(${CMAKE_CURRENT_SOURCE_DIR} STREQUAL
            ${${stripped_target_name}.source_directory})

          foreach(linkage PUBLIC PRIVATE INTERFACE)
            get_target_property(sources
              ${stripped_target_name}.generated_sources.${linkage}
              INTERFACE_SOURCES)

            foreach(source IN LISTS sources)
              set_source_files_properties(${source} PROPERTIES GENERATED TRUE)
            endforeach()

            target_link_libraries(${target} ${linkage}
              $<BUILD_INTERFACE:${stripped_target_name}.generated_sources.${linkage}>)
          endforeach()
        endif()
      endif()
    endfunction()

    variable_watch(CMAKE_BACKWARDS_COMPATIBILITY ${stripped_target_name}_append_generated_files)
    unset(stripped_target_name)
  endmacro()

  set_property(GLOBAL PROPERTY GeneratedSources.generated_sources_trap.cmake
    "This is a header guard")
endif()
