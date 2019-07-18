cmake_minimum_required(VERSION 3.12.1)
include_guard(DIRECTORY)

include("${CMAKE_CURRENT_LIST_DIR}/config.cmake")
if(shacl.cmake.installation)
  get_property(
    shacl.cmake.installed_modules GLOBAL PROPERTY shacl.cmake.installed_modules)

  if(NOT "DependentCacheVariable" IN_LIST shacl.cmake.installed_modules)
    set_property(GLOBAL APPEND PROPERTY
      shacl.cmake.installed_modules "DependentCacheVariable")

    install(
      FILES "${CMAKE_CURRENT_LIST_FILE}"
      DESTINATION share/cmake/shacl/.cmake)
  endif()

  unset(shacl.cmake.installed_modules)
endif()

include_guard(GLOBAL)
function(dependent_cache_variable variable)
  set(OPTIONS)
  set(UNARY_ARGUMENTS TYPE DOCSTRING)
  set(VARIADIC_ARGUMENTS DEFAULT CONDITION FALLBACK)

  set(arguments)
  foreach(argument IN LISTS ARGN)
    if(argument MATCHES ".*[ ].*"  # argument with embedded whitespace
        OR argument MATCHES ".*[;].*"  # argument list
        OR argument MATCHES "\".*\"")  # quoted argument
      list(APPEND arguments "\"${argument}\"")
    elseif(argument STREQUAL "")
      list(APPEND arguments "\"\"")
    else()
      list(APPEND arguments "${argument}")
    endif()
  endforeach()

  cmake_parse_arguments(dcv
    "${OPTIONS}"
    "${UNARY_ARGUMENTS}"
    "${VARIADIC_ARGUMENTS}" ${arguments})

  if(NOT DEFINED dcv_DEFAULT)
    message(FATAL_ERROR
      "dependent_cache_variable invoked without 'DEFAULT' argument")
  endif()
  if(dcv_DEFAULT MATCHES "\"(.*)\"")
    set(dcv_DEFAULT "${CMAKE_MATCH_1}")
  endif()

  if(NOT DEFINED dcv_DOCSTRING)
    message(FATAL_ERROR
      "dependent_cache_variable invoked without 'DOCSTRING' argument")
  endif()
  if(dcv_DOCSTRING MATCHES "\"(.*)\"")
    set(dcv_DOCSTRING "${CMAKE_MATCH_1}")
  endif()

  if(NOT DEFINED dcv_TYPE)
    message(FATAL_ERROR
      "dependent_cache_variable invoked without 'TYPE' argument")
  endif()

  set(valid_types FILEPATH PATH STRING BOOL INTERNAL)
  if(NOT dcv_TYPE IN_LIST valid_types)
    message("dependent_cache_variable error")
    message("TYPE argument value: ${dcv_TYPE}")
    message(FATAL_ERROR
      "TYPE argument must be one of FILEPATH, PATH, STRING, BOOL, or INTERNAL")
  endif()

  if(NOT DEFINED dcv_CONDITION)
    message(FATAL_ERROR
      "dependent_cache_variable invoked without 'CONDITION' argument")
  endif()

  if(NOT DEFINED dcv_FALLBACK)
    message(FATAL_ERROR
      "dependent_cache_variable invoked without 'FALLBACK' argument")
  endif()
  if(dcv_FALLBACK MATCHES "\"(.*)\"")
    set(dcv_FALLBACK "${CMAKE_MATCH_1}")
  endif()

  if(DEFINED dcv_UNPARSED_ARGUMENTS)
    message(FATAL_ERROR
      "dependent_cache_variable invoked with unrecognized arguments: ${dcv_UNPARSED_ARGUMENTS}")
  endif()

  set(available TRUE)
  foreach(condition IN LISTS dcv_CONDITION)
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
      set(${variable} "${dcv_DEFAULT}" CACHE "${dcv_TYPE}" "${dcv_DOCSTRING}")
      set(${variable} "${${variable}}" CACHE "${dcv_TYPE}" "${dcv_DOCSTRING}" FORCE)
    endif()
  else()
    if(DEFINED ${variable})
      set(${variable} "${${variable}}" CACHE INTERNAL "${dcv_DOCSTRING}")
    else(NOT variable.set)
      set(${variable} "${dcv_DEFAULT}" CACHE INTERNAL "${dcv_DOCSTRING}")
    endif()
    set(${variable} "${dcv_FALLBACK}")
  endif()

  set_property(GLOBAL PROPERTY "${variable}.set" "")

  set(${variable} "${${variable}}" PARENT_SCOPE)
endfunction()
