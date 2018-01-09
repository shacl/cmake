# Here we're using the existance of global properties to act as something
# analoguous to C/C++ header guards to ensure the contents of this file are not
# redunantly defined.

get_property(
  FunctionExtension.backup.cmake
  GLOBAL PROPERTY FunctionExtension.backup.cmake SET)

if(NOT FunctionExtension.backup.cmake)
  function(backup func)
    function(___________${func})
    endfunction()

    function(__________${func})
    endfunction()

    function(_________${func})
    endfunction()

    function(________${func})
    endfunction()

    function(_______${func})
    endfunction()

    function(______${func})
    endfunction()

    function(_____${func})
    endfunction()

    function(____${func})
    endfunction()

    function(___${func})
    endfunction()

    function(__${func})
    endfunction()

    function(${func})
    endfunction()

    function(_${func})
    endfunction()
  endfunction()

  set_property(
    GLOBAL PROPERTY FunctionExtension.backup.cmake
    "This is a header guard")

endif()
