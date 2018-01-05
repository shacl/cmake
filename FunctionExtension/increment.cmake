# Here we're using the existance of global properties to act as something
# analoguous to C/C++ header guards to ensure the contents of this file are not
# redundantly defined.

get_property(
  FunctionExtension.increment.cmake
  GLOBAL PROPERTY FunctionExtension.increment.cmake SET)

if(NOT FunctionExtension.increment.cmake)

  macro(increment n)
    MATH(EXPR n "${n}+1")
  endmacro()

  set_property(
    GLOBAL PROPERTY FunctionExtension.increment.cmake
    "This is a header guard")

endif()
