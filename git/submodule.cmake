# Here we're using the existance of global properties to act as something
# analoguous to C/C++ header guards to ensure the contents of this file are not
# redundantly defined.

get_property(
  git.submodule.cmake
  GLOBAL PROPERTY git.submodule.cmake SET)

if(NOT git.submodule.cmake)
  include(git/submodule/packages)

  set_property(
    GLOBAL PROPERTY git.submodule.cmake
    "This is a header guard")
endif()
