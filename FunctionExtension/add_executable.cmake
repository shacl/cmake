# Here we're using the existance of global properties to act as something
# analoguous to C/C++ header guards to ensure the contents of this file are not
# redundantly defined.

get_property(
  FunctionExtension.add_executable.cmake
  GLOBAL PROPERTY FunctionExtension.add_executable.cmake SET)

if(NOT FunctionExtension.add_executable.cmake)

  macro(previous_add_executable)
    if(NOT previous_add_executable.recursion_depth)
      set(previous_add_executable.recursion_depth 0)
    endif()

    increment(previous_add_executable.recursion_depth)

    if(previous_add_executable.recursion_depth EQUAL 1)
      __add_executable(${ARGV} "")
    elseif(previous_add_executable.recursion_depth EQUAL 2)
      ___add_executable(${ARGV} "")
    elseif(previous_add_executable.recursion_depth EQUAL 3)
      ____add_executable(${ARGV} "")
    elseif(previous_add_executable.recursion_depth EQUAL 4)
      _____add_executable(${ARGV} "")
    elseif(previous_add_executable.recursion_depth EQUAL 5)
      ______add_executable(${ARGV} "")
    elseif(previous_add_executable.recursion_depth EQUAL 6)
      _______add_executable(${ARGV} "")
    elseif(previous_add_executable.recursion_depth EQUAL 7)
      ________add_executable(${ARGV} "")
    elseif(previous_add_executable.recursion_depth EQUAL 8)
      _________add_executable(${ARGV} "")
    elseif(previous_add_executable.recursion_depth EQUAL 9)
      __________add_executable(${ARGV} "")
    elseif(previous_add_executable.recursion_depth EQUAL 10)
      ___________add_executable(${ARGV} "")
    else()
      message(FATAL_ERROR "maximum recursion depth exceeded")
    endif()

    decrement(previous_add_executable.recursion_depth)

    if(previous_add_executable.recursion_depth EQUAL 0)
      unset(previous_add_executable.recursion_depth)
    endif()
  endmacro()

  set_property(
    GLOBAL PROPERTY FunctionExtension.add_executable.cmake
    "This is a header guard")

endif()
