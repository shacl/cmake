cmake_minimum_required(VERSION 3.12.1)
include_guard(DIRECTORY)

include("${CMAKE_CURRENT_LIST_DIR}/config.cmake")
if(shacl.cmake.installation)
  get_property(
    shacl.cmake.installed_modules GLOBAL PROPERTY shacl.cmake.installed_modules)

  if(NOT "GenerateFile" IN_LIST shacl.cmake.installed_modules)
    set_property(GLOBAL APPEND PROPERTY
      shacl.cmake.installed_modules "GenerateFile")

    install(
      FILES "${CMAKE_CURRENT_LIST_FILE}"
      DESTINATION share/cmake/shacl/.cmake/Fortran)
  endif()

  unset(shacl.cmake.installed_modules)
endif()

include_guard(GLOBAL)
function(generate_file)
  set(OPTIONS)
  set(UNARY_ARGUMENTS)
  set(VARIADIC_ARGUMENTS OUTPUT WORKING_DIRECTORY DEPENDS COMMAND)

  set(arguments)
  foreach(argument IN LISTS ARGN)
    if(argument MATCHES ".*[ ].*")
      list(APPEND arguments "\"${argument}\"")
    elseif(argument STREQUAL "")
      list(APPEND arguments "\"\"")
    else()
      list(APPEND arguments "${argument}")
    endif()
  endforeach()

  cmake_parse_arguments(gf
    "${OPTIONS}"
    "${UNARY_ARGUMENTS}"
    "${VARIADIC_ARGUMENTS}" ${arguments})

  if(NOT DEFINED gf_OUTPUT)
    message(FATAL_ERROR "generate_file called without OUTPUT argument")
  endif(NOT DEFINED gf_OUTPUT)

  if(gf_OUTPUT MATCHES "\"(.*)\"")
    set(gf_OUTPUT "${CMAKE_MATCH_1}")
  endif()

  if(NOT DEFINED gf_COMMAND)
    message(FATAL_ERROR "generate_file called without COMMAND argument")
  endif()

  set(command)
  set(dependency_variables)
  foreach(component IN LISTS gf_COMMAND)
    if(component MATCHES "\"(.*)\"")
      set(component "${CMAKE_MATCH_1}")
    endif()

    list(APPEND command "${component}")
  endforeach()

  if(NOT DEFINED gf_WORKING_DIRECTORY)
    set(gf_WORKING_DIRECTORY "${CMAKE_CURRENT_LIST_DIR}")
  endif(NOT DEFINED gf_WORKING_DIRECTORY)
  if(gf_WORKING_DIRECTORY MATCHES "\"(.*)\"")
    set(gf_WORKING_DIRECTORY "${CMAKE_MATCH_1}")
  endif()

  if(NOT IS_ABSOLUTE "${gf_OUTPUT}")
    set(gf_OUTPUT "${gf_WORKING_DIRECTORY}/${gf_OUTPUT}")
  endif()

  if(gf_DEPENDS)
    set(generate FALSE)
    foreach(dependency IN LISTS gf_DEPENDS)
      if(dependency MATCHES "\"(.*)\"")
        set(dependency "${CMAKE_MATCH_1}")
      endif()

      if(NOT IS_ABSOLUTE "${dependency}")
        set(dependency "${gf_WORKING_DIRECTORY}/${dependency}")
      endif()

      if(NOT EXISTS "${dependency}")
        message(FATAL_ERROR "${dependency}")
      endif()

      if("${dependency}" IS_NEWER_THAN "${gf_OUTPUT}")
        set(generate TRUE)
        break()
      endif()
    endforeach()
  else()
    if(EXISTS "${gf_OUTPUT}")
      set(generate FALSE)
    else()
      set(generate TRUE)
    endif()
  endif()

  if(generate)
    execute_process(
      COMMAND ${command}
      WORKING_DIRECTORY "${gf_WORKING_DIRECTORY}"
      RESULT_VARIABLE failure
      OUTPUT_VARIABLE output
      ERROR_VARIABLE output)

    if(failure)
      string(CONCAT
        error_message
        "Encountered error while generating ${gf_OUTPUT}\n"
        "COMMAND: ${command}\n"
        "OUTPUT: ${output}\n")
      message(FATAL_ERROR "${error_message}")
    endif()
  endif()
endfunction()
