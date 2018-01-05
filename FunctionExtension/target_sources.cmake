# Here we're using the existance of global properties to act as something
# analoguous to C/C++ header guards to ensure the contents of this file are not
# redundantly defined.

get_property(
  FunctionExtension.target_sources.cmake
  GLOBAL PROPERTY FunctionExtension.target_sources.cmake SET)

if(NOT FunctionExtension.target_sources.cmake)

  macro(previous_target_sources)
    if(NOT previous_target_sources.recursion_depth)
      set(previous_target_sources.recursion_depth 0)
    endif()

    increment(previous_target_sources.recursion_depth)

    if(previous_target_sources.recursion_depth EQUAL 1)
      __target_sources(${ARGV})
    elseif(previous_target_sources.recursion_depth EQUAL 2)
      ___target_sources(${ARGV})
    elseif(previous_target_sources.recursion_depth EQUAL 3)
      ____target_sources(${ARGV})
    elseif(previous_target_sources.recursion_depth EQUAL 4)
      _____target_sources(${ARGV})
    elseif(previous_target_sources.recursion_depth EQUAL 5)
      ______target_sources(${ARGV})
    elseif(previous_target_sources.recursion_depth EQUAL 6)
      _______target_sources(${ARGV})
    elseif(previous_target_sources.recursion_depth EQUAL 7)
      ________target_sources(${ARGV})
    elseif(previous_target_sources.recursion_depth EQUAL 8)
      _________target_sources(${ARGV})
    elseif(previous_target_sources.recursion_depth EQUAL 9)
      __________target_sources(${ARGV})
    elseif(previous_target_sources.recursion_depth EQUAL 10)
      ___________target_sources(${ARGV})
    else()
      message(FATAL "maximum recursion depth exceeded")
    endif()

    decrement(previous_target_sources.recursion_depth)

    if(previous_target_sources.recursion_depth EQUAL 0)
      unset(previous_target_sources.recursion_depth)
    endif()
  endmacro()

  set_property(
    GLOBAL PROPERTY FunctionExtension.target_sources.cmake
    "This is a header guard")

endif()
