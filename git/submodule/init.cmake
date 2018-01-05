# Here we're using the existance of global properties to act as something
# analoguous to C/C++ header guards to ensure the contents of this file are not
# redundantly defined.

get_property(
  git.submodule.init.cmake
  GLOBAL PROPERTY git.submodule.init.cmake SET)

if(NOT git.submodule.init.cmake)
  function(git_submodule_init name)
    execute_process(
      COMMAND "${GIT_EXECUTABLE} submodule update --init -- ${${name}.path}"
      WORKING_DIRECTORY "${PROJECT_SOURCE_DIR}")
  endfunction()

  set_property(
    GLOBAL PROPERTY git.submodule.init.cmake
    "This is a header guard")
endif()
