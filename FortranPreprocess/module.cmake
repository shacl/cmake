# Here we're using the existance of global properties to act as something
# analoguous to C/C++ header guards to ensure the contents of this file are not
# redundantly defined.
get_property(
  FortranPreprocess.module.cmake GLOBAL PROPERTY
  FortranPreprocess.module.cmake SET)

if(NOT FortranPreprocess.module.cmake)
  include(FortranPreprocess/target_sources)

  set_property(
    GLOBAL PROPERTY FortranPreprocess.module.cmake
    "This is a header guard")
endif()
