# Here we're using the existance of global properties to act as something
# analoguous to C/C++ header guards to ensure the contents of this file are not
# redunantly defined.

get_property(
  GeneratedSources.target_sources.cmake
  GLOBAL PROPERTY GeneratedSources.target_sources.cmake SET)

if(NOT GeneratedSources.target_sources.cmake)

  function(target_sources target tag linkage)
    if(NOT ${tag} STREQUAL "GENERATED")
      _target_sources(${ARGV})
      return()
    endif()

    foreach(entry IN LISTS ARGN)
      if(entry STREQUAL "PUBLIC"
          OR entry STREQUAL "PRIVATE"
          OR entry STREQUAL "INTERFACE")
        set(linkage ${entry})
      else()
        string(REGEX MATCH "[$]<.*>$" generator_expression ${entry})

        if("${generator_expression}" STREQUAL "${entry}")
          message(FATAL_ERROR
            "Generator expressions are unavailable in GENERATED target_sources invocations")
        endif()

        _target_sources(
          ${target}.generated_sources.${linkage} INTERFACE "${entry}")

        if(IS_ABSOLUTE "${entry}")
          file(RELATIVE_PATH relative_path "${PROJECT_BINARY_DIR}" "${entry}")
        else()
          file(RELATIVE_PATH relative_path
            "${PROJECT_BINARY_DIR}"
            "${CMAKE_CURRENT_BINARY_DIR}/${entry}")
        endif()

        string(REPLACE "/" "_" relative_path "${relative_path}")
        string(REPLACE "." "_" relative_path "${relative_path}")
        string(REPLACE " " "_" relative_path "${relative_path}")

        set(custom_target
          ${target}.generated_sources.${linkage}.path.${relative_path})

        add_custom_target(${custom_target} DEPENDS ${entry})

        set_target_properties(
          ${custom_target} PROPERTIES FOLDER .generated_sources/dummy)

        add_dependencies(
          ${target}.generated_sources.${linkage}
          ${custom_target})
      endif()
    endforeach()
  endfunction()

  set_property(
    GLOBAL PROPERTY GeneratedSources.target_sources.cmake
    "This is a header guard")
endif()
