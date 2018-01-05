# Here we're using the existance of global properties to act as something
# analoguous to C/C++ header guards to ensure the contents of this file are not
# redundantly defined.

get_property(
  FunctionExtension.cmake
  GLOBAL PROPERTY FunctionExtension.cmake SET)

if(NOT FunctionExtension.cmake)
  include(FunctionExtension/increment)
  include(FunctionExtension/decrement)
  include(FunctionExtension/add_library)
  include(FunctionExtension/add_executable)
  include(FunctionExtension/target_sources)
  include(FunctionExtension/find_package)

  set_property(
    GLOBAL PROPERTY FunctionExtension.cmake
    "This is a header guard")

endif()
