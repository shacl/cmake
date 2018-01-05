# Here we're using the existance of global properties to act as something
# analoguous to C/C++ header guards to ensure the contents of this file are not
# redundantly defined.

get_property(
  FunctionExtension.decrement.cmake
  GLOBAL PROPERTY FunctionExtension.decrement.cmake SET)

if(NOT FunctionExtension.decrement.cmake)
  macro(decrement n)
    MATH(EXPR n "${n}-1")
  endmacro()

  set_property(
    GLOBAL PROPERTY FunctionExtension.decrement.cmake
    "This is a header guard")

endif()
