# Here we're using the existance of global properties to act as something
# analoguous to C/C++ header guards to ensure the contents of this file are not
# redundantly defined.

get_property(
  FunctionExtension.add_library.cmake
  GLOBAL PROPERTY FunctionExtension.add_library.cmake SET)

if(NOT FunctionExtension.add_library.cmake)

  macro(previous_add_library)
    if(NOT previous_add_library.recursion_depth)
      set(previous_add_library.recursion_depth 0)
    endif()

    increment(previous_add_library.recursion_depth)

    if(previous_add_library.recursion_depth EQUAL 1)
      __add_library(${ARGV})
    elseif(previous_add_library.recursion_depth EQUAL 2)
      ___add_library(${ARGV})
    elseif(previous_add_library.recursion_depth EQUAL 3)
      ____add_library(${ARGV})
    elseif(previous_add_library.recursion_depth EQUAL 4)
      _____add_library(${ARGV})
    elseif(previous_add_library.recursion_depth EQUAL 5)
      ______add_library(${ARGV})
    elseif(previous_add_library.recursion_depth EQUAL 6)
      _______add_library(${ARGV})
    elseif(previous_add_library.recursion_depth EQUAL 7)
      ________add_library(${ARGV})
    elseif(previous_add_library.recursion_depth EQUAL 8)
      _________add_library(${ARGV})
    elseif(previous_add_library.recursion_depth EQUAL 9)
      __________add_library(${ARGV})
    elseif(previous_add_library.recursion_depth EQUAL 10)
      ___________add_library(${ARGV})
    else()
      message(FATAL "maximum recursion depth exceeded")
    endif()

    decrement(previous_add_library.recursion_depth)

    if(previous_add_library.recursion_depth EQUAL 0)
      unset(previous_add_library.recursion_depth)
    endif()
  endmacro()

  set_property(
    GLOBAL PROPERTY FunctionExtension.add_library.cmake
    "This is a header guard")

endif()
