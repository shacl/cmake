function(git_submodule_clone name)
  execute_process(
    COMMAND "${GIT_EXECUTABLE} submodule update --init -- ${${name}.path}"
    WORKING_DIRECTORY "${PROJECT_SOURCE_DIR}")
endfunction()
