backup(target_sources)

function(target_sources target tag linkage)
  if(NOT ${tag} STREQUAL "GENERATED")
    previous_target_sources(${ARGV})
    return()
  endif()

  stripped(${target})
  foreach(entry ${ARGN})
    if(entry STREQUAL "PUBLIC"
        OR entry STREQUAL "PRIVATE"
        OR entry STREQUAL "INTERFACE")
      set(linkage ${entry})
    else()
      string(REGEX MATCH "[$]<.*>$" generator_expression ${entry})
      if("${generator_expression}")
        message(FATAL_ERROR
          "Generator expressions are unavailable in GENERATED target_sources invocations")
      endif()

      unset(generator_expression)
      previous_target_sources(${stripped_target_name}.generated_sources.${linkage} INTERFACE "${entry}")
      file(RELATIVE_PATH relative_path "${PROJECT_BINARY_DIR}" "${entry}")

      string(REPLACE "/" "_" relative_path "${relative_path}")
      string(REPLACE "." "_" relative_path "${relative_path}")
      string(REPLACE " " "_" relative_path "${relative_path}")

      set(custom_target
        ${stripped_target_name}.generated_sources.${linkage}.path.${relative_path})

      add_custom_target(${custom_target} DEPENDS ${entry})

      set_target_properties(
        ${custom_target} PROPERTIES FOLDER .generated_sources/dummy)

      add_dependencies(
        ${stripped_target_name}.generated_sources.${linkage}
        ${custom_target})
    endif()
  endforeach()
endfunction()
