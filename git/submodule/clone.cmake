# Here we're using the existance of global properties to act as something
# analoguous to C/C++ header guards to ensure the contents of this file are not
# redundantly defined.

get_property(
  git.submodule.clone.cmake
  GLOBAL PROPERTY git.submodule.clone.cmake SET)

if(NOT git.submodule.clone.cmake)
  function(git_submodule_clone name)
    execute_process(
      COMMAND "${GIT_EXECUTABLE} submodule update --init -- ${${name}.path}"
      WORKING_DIRECTORY "${PROJECT_SOURCE_DIR}")
  endfunction()

  set_property(
    GLOBAL PROPERTY git.submodule.clone.cmake
    "This is a header guard")
endif()
