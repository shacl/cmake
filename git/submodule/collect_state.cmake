# Here we're using the existance of global properties to act as something
# analoguous to C/C++ header guards to ensure the contents of this file are not
# redundantly defined.

get_property(
  git.submodule.collect_state.cmake
  GLOBAL PROPERTY git.submodule.collect_state.cmake SET)

if(NOT git.submodule.collect_state.cmake)

  # This macro populates the current_hash and current_branch variables
  macro(git_submodule_collect_state name)
    execute_process(
      COMMAND ${GIT_EXECUTABLE} rev-parse HEAD
      WORKING_DIRECTORY "${${name}.submodule.path}"
      RESULT_VARIABLE failure
      OUTPUT_VARIABLE current_hash
      ERROR_VARIABLE error_output)

    if(failure)
      message(FATAL ${error_output})
    endif()

    execute_process(
      COMMAND ${GIT_EXECUTABLE} rev-parse --abbrev-ref HEAD
      WORKING_DIRECTORY "${${name}.submodule.path}"
      RESULT_VARIABLE failure
      OUTPUT_VARIABLE current_branch
      ERROR_VARIABLE error_output)

    if(failure)
      message(FATAL ${error_output})
    endif()

    if(current_branch STREQUAL HEAD)
      set(current_branch "")
    endif()

    unset(failure)
    unset(error_output)
  endmacro()

  set_property(
    GLOBAL PROPERTY git.submodule.collect_state.cmake
    "This is a header guard")
endif()
