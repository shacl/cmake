# Here we're using the existance of global properties to act as something
# analoguous to C/C++ header guards to ensure the contents of this file are not
# redunantly defined.

get_property(
  FunctionExtension.backup.cmake
  GLOBAL PROPERTY FunctionExtension.backup.cmake SET)

if(NOT FunctionExtension.backup.cmake)
  macro(backup func)
    macro(___________${func})
      message("dummy")
    endmacro()

    macro(__________${func})
      message("dummy")
    endmacro()

    macro(_________${func})
      message("dummy")
    endmacro()

    macro(________${func})
      message("dummy")
    endmacro()

    macro(_______${func})
      message("dummy")
    endmacro()

    macro(______${func})
      message("dummy")
    endmacro()

    macro(_____${func})
      message("dummy")
    endmacro()

    macro(____${func})
      message("dummy")
    endmacro()

    macro(___${func})
      message("dummy")
    endmacro()

    macro(__${func})
      message("dummy")
    endmacro()

    macro(${func})
      message("dummy")
    endmacro()

    macro(_${func})
      message("dummy")
    endmacro()
  endmacro()

  set_property(GLOBAL PROPERTY FunctionExtension.backup.cmake 
    "This is a header guard")
endif()
