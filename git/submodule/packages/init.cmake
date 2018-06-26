function(git_submodule_init name)
  if(NOT EXISTS "${${name}.submodule.path}/.git" )
    execute_process(
      COMMAND ${GIT_EXECUTABLE} submodule update --init -- ${${name}.submodule.path}
      WORKING_DIRECTORY "${PROJECT_SOURCE_DIR}"
      OUTPUT_QUIET
      RESULT_VARIABLE failure
      ERROR_VARIABLE error_output)

    if(failure)
      message(FATAL "${error_output}")
    endif()
  endif()

  git_submodule_collect_state(${name})

  if(NOT ${name}.submodule.hash)
    set(${name}.submodule.hash ${current_hash} CACHE STRING
      "${name} git submodule hash")
  endif()

  if(NOT DEFINED ${name}.submodule.branch)
    if(git.submodule.update)
      set(${name}.submodule.branch ${git.submodule.default_branch} CACHE STRING
        "${name} git submodule branch")
    else()
      set(${name}.submodule.branch ${current_branch} CACHE STRING
        "${name} git submodule branch")
    endif()
  endif()
endfunction()
