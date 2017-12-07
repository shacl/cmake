function(git.submodule.clone name)
  execute_process(
      COMMAND "${GIT_EXECUTABLE} submodule update --init -- ${${name}_path}"
      WORKING_DIRECTORY "${PROJECT_SOURCE_DIR}")
endfunction()
