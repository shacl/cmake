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
