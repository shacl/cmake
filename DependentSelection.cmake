cmake_minimum_required(VERSION 3.12.1)
include_guard(DIRECTORY)

include("${CMAKE_CURRENT_LIST_DIR}/config.cmake")
if(shacl.cmake.installation)
  get_property(
    shacl.cmake.installed_modules GLOBAL PROPERTY shacl.cmake.installed_modules)

  if(NOT "DependentSelection" IN_LIST shacl.cmake.installed_modules)
    set_property(GLOBAL APPEND PROPERTY
      shacl.cmake.installed_modules "DependentSelection")

    install(
      FILES "${CMAKE_CURRENT_LIST_FILE}"
      DESTINATION share/cmake/shacl/.cmake)
  endif()

  unset(shacl.cmake.installed_modules)
endif()

include_guard(GLOBAL)
function(dependent_selection variable)
  set(OPTIONS)
  set(UNARY_ARGUMENTS DEFAULT DOCSTRING FALLBACK)
  set(VARIADIC_ARGUMENTS OPTIONS CONDITION)

  set(arguments)
  set(options)
  foreach(argument IN LISTS ARGN)
    if(argument MATCHES ".*[ ].*"  # argument with embedded whitespace
        OR argument MATCHES ".*[;].*"  # argument list
        OR argument MATCHES "\".*\"")  # quoted argument
      list(APPEND arguments "\"${argument}\"")
    elseif(argument STREQUAL "")
      list(APPEND arguments "\"\"")
      set(options ";")
    else()
      list(APPEND arguments "${argument}")
    endif()
  endforeach()

  cmake_parse_arguments(ds
    "${OPTIONS}"
    "${UNARY_ARGUMENTS}"
    "${VARIADIC_ARGUMENTS}" ${arguments})

  if(NOT DEFINED ds_DEFAULT)
    message(FATAL_ERROR
      "dependent_selection invoked without 'DEFAULT' argument")
  endif()
  if(ds_DEFAULT MATCHES "\"(.*)\"")
    set(ds_DEFAULT "${CMAKE_MATCH_1}")
  endif()

  if(NOT DEFINED ds_DOCSTRING)
    message(FATAL_ERROR
      "dependent_selection invoked without 'DOCSTRING' argument")
  endif()
  if(ds_DOCSTRING MATCHES "\"(.*)\"")
    set(ds_DOCSTRING "${CMAKE_MATCH_1}")
  endif()

  if(NOT DEFINED ds_CONDITION)
    message(FATAL_ERROR
      "dependent_selection invoked without 'CONDITION' argument")
  endif()

  if(NOT DEFINED ds_FALLBACK)
    message(FATAL_ERROR
      "dependent_selection invoked without 'FALLBACK' argument")
  endif()
  if(ds_FALLBACK MATCHES "\"(.*)\"")
    set(ds_FALLBACK "${CMAKE_MATCH_1}")
  endif()

  if(NOT DEFINED ds_OPTIONS)
    message(FATAL_ERROR
      "dependent_selection invoked without 'OPTIONS' keyword")
  endif()

  foreach(option IN LISTS ds_OPTIONS)
    if(option MATCHES "\"(.*)\"")
      set(option "${CMAKE_MATCH_1}")
    endif()
    list(APPEND options "${option}")
  endforeach()

  if(DEFINED ds_UNPARSED_ARGUMENTS)
    message(FATAL_ERROR
      "dependent_selection invoked with unrecognized arguments: ${ds_UNPARSED_ARGUMENTS}")
  endif()

  set(available TRUE)
  foreach(condition IN LISTS ds_CONDITION)
    if(condition MATCHES "\"(.*)\"")
      set(condition "${CMAKE_MATCH_1}")
    endif()
    string(REGEX REPLACE " +" ";" condition "${condition}")
    if(${condition})
    else()
      set(available FALSE)
      break()
    endif()
  endforeach()

  get_property(variable.set GLOBAL PROPERTY "${variable}.set" SET)

  if(available)
    if(NOT variable.set)
      set(${variable} "${ds_DEFAULT}" CACHE STRING "${ds_DOCSTRING}")
      set_property(CACHE ${variable} PROPERTY STRINGS "${options}")
      set(${variable} "${${variable}}" CACHE STRING "${ds_DOCSTRING}" FORCE)
    endif()
  else()
    if(DEFINED ${variable})
      set(${variable} "${${variable}}" CACHE INTERNAL "${ds_DOCSTRING}")
    elseif(NOT variable.set)
      set(${variable} "${ds_DEFAULT}" CACHE INTERNAL "${ds_DOCSTRING}")
    endif()
    set(${variable} "${ds_FALLBACK}")
  endif()

  set_property(GLOBAL PROPERTY "${variable}.set" "")

  if(NOT ${variable} IN_LIST ds_OPTIONS)
    message("${variable} set to ${${variable}}")
    set(error_message "${variable} must be one of:")
    foreach(option_string IN LISTS ds_OPTIONS)
      string(CONCAT error_message "${error_message}\n" "  ${option_string}")
    endforeach()
    message(FATAL_ERROR "${error_message}")
  endif()

  set(${variable} "${${variable}}" PARENT_SCOPE)
endfunction()
