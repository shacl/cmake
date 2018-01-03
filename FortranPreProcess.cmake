# Here we're using the existance of global properties to act as something
# analoguous to C/C++ header guards to ensure the contents of this file are not
# redundantly defined.
get_property(FortranPreProcess.cmake GLOBAL PROPERTY FortranPreProcess.cmake SET)

if(NOT FortranPreProcess.cmake)
  include(FortranPreProcess/target_sources)
  set_property( GLOBAL PROPERTY FortranPreProcess.cmake
    "This is a header guard")
endif()
