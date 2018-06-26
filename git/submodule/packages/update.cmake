function(git_submodule_update name)
  git_submodule_collect_state(${name})

  if(${name}.submodule.branch)

    if(NOT current_branch STREQUAL ${name}.submodule.branch)
      execute_process(
        COMMAND ${GIT_EXECUTABLE} checkout ${${name}.submodule.branch}
        WORKING_DIRECTORY "${${name}.submodule.path}"
        OUTPUT_QUIET
        RESULT_VARIABLE failure
        ERROR_VARIABLE error_output)

      if(failure)
        message(FATAL ${error_output})
      endif()
    endif()

    if(git.submodule.update)
      execute_process(
        COMMAND ${GIT_EXECUTABLE} pull
        WORKING_DIRECTORY "${${name}.submodule.path}"
        OUTPUT_QUIET
        RESULT_VARIABLE failure
        ERROR_VARIABLE error_output)

      if(failure)
        message(FATAL ${error_output})
      endif()
    endif()

    git_submodule_collect_state(${name})

    set(${name}.submodule.hash ${current_hash} CACHE STRING
      "${name} git submodule hash" FORCE)

  else()
    if(NOT ${name}.submodule.hash)
      set(${name}.submodule.hash ${current_hash} CACHE STRING
        "${name} git submodule hash" FORCE)
    endif()

    if(git.submodule.update)
      execute_process(
        COMMAND ${GIT_EXECUTABLE} fetch
        WORKING_DIRECTORY "${${name}.submodule.path}"
        OUTPUT_QUIET
        RESULT_VARIABLE failure
        ERROR_VARIABLE error_output)

      if(failure)
        message(FATAL ${error_output})
      endif()
    endif()

    if(NOT current_hash STREQUAL ${name}.submodule.hash)
      execute_process(
        COMMAND ${GIT_EXECUTABLE} checkout ${${name}.submodule.hash}
        WORKING_DIRECTORY "${${name}.submodule.path}"
        OUTPUT_QUIET
        RESULT_VARIABLE failure
        ERROR_VARIABLE error_output)

      if(failure)
        message(FATAL ${error_output})
      endif()
    endif()

  endif()
endfunction()
