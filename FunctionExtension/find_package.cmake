# Here we're using the existance of global properties to act as something
# analoguous to C/C++ header guards to ensure the contents of this file are not
# redundantly defined.

get_property(
  FunctionExtension.find_package.cmake
  GLOBAL PROPERTY FunctionExtension.find_package.cmake SET)

if(NOT FunctionExtension.find_package.cmake)

  macro(previous_find_package)
    if(NOT previous_find_package.recursion_depth)
      set(previous_find_package.recursion_depth 0)
    endif()

    increment(previous_find_package.recursion_depth)

    if(previous_find_package.recursion_depth EQUAL 1)
      __find_package(${ARGV})
    elseif(previous_find_package.recursion_depth EQUAL 2)
      ___find_package(${ARGV})
    elseif(previous_find_package.recursion_depth EQUAL 3)
      ____find_package(${ARGV})
    elseif(previous_find_package.recursion_depth EQUAL 4)
      _____find_package(${ARGV})
    elseif(previous_find_package.recursion_depth EQUAL 5)
      ______find_package(${ARGV})
    elseif(previous_find_package.recursion_depth EQUAL 6)
      _______find_package(${ARGV})
    elseif(previous_find_package.recursion_depth EQUAL 7)
      ________find_package(${ARGV})
    elseif(previous_find_package.recursion_depth EQUAL 8)
      _________find_package(${ARGV})
    elseif(previous_find_package.recursion_depth EQUAL 9)
      __________find_package(${ARGV})
    elseif(previous_find_package.recursion_depth EQUAL 10)
      ___________find_package(${ARGV})
    else()
      message(FATAL "maximum recursion depth exceeded")
    endif()

    decrement(previous_find_package.recursion_depth)

    if(previous_find_package.recursion_depth EQUAL 0)
      unset(previous_find_package.recursion_depth)
    endif()
  endmacro()

  set_property(
    GLOBAL PROPERTY FunctionExtension.find_package.cmake
    "This is a header guard")

endif()
