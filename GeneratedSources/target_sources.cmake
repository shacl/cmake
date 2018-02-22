backup(target_sources)

function(target_sources target tag linkage)
  if(NOT ${tag} STREQUAL "GENERATED")
    previous_target_sources(${ARGV})
    return()
  endif()

  get_target_property(library_type ${target} TYPE)
    
  stripped(${target})
  foreach(entry ${ARGN})
    if(entry STREQUAL "PUBLIC"
        OR entry STREQUAL "PRIVATE"
        OR entry STREQUAL "INTERFACE")

      if(library_type STREQUAL "INTERFACE_LIBRARY"
          AND NOT entry STREQUAL "INTERFACE")
        message(FATAL_ERROR 
          "Only interface sources may be added to interface targets")
      endif()

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

      #string(REPLACE "/" "_" relative_path "${relative_path}")
      #string(REPLACE "." "_" relative_path "${relative_path}")
      #string(REPLACE " " "_" relative_path "${relative_path}")
      string(SHA512 path_hash ${relative_path})

      #set(custom_target
      #  ${stripped_target_name}.generated_sources.${linkage}.path.${relative_path})
      
      set(custom_target ${stripped_target_name}.${path_hash})
      add_custom_target(${custom_target} DEPENDS ${entry})

      set_target_properties(
        ${custom_target} PROPERTIES FOLDER .generated_sources/dummy)

      add_dependencies(
        ${stripped_target_name}.generated_sources.${linkage}
        ${custom_target})
    endif()
  endforeach()
endfunction()
