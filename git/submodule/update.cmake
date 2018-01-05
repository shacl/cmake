# Here we're using the existance of global properties to act as something
# analoguous to C/C++ header guards to ensure the contents of this file are not
# redundantly defined.

get_property(
  git.submodule.update.cmake
  GLOBAL PROPERTY git.submodule.update.cmake SET)

if(NOT git.submodule.update.cmake)
  function(git_submodule_update name)

    if(${name}.submodule.branch)
      if(${name}.submodule.hash)
        unset(${name}.submodule.hash CACHE)
        unset(${name}.submodule.current_hash CACHE)
        unset(${name}.submodule.current_branch CACHE)
      endif()

      if(NOT "${${name}.submodule.current_branch}"
          STREQUAL ${name}.submodule.branch)
        execute_process(
          COMMAND ${GIT_EXECUTABLE} checkout ${${name}.submodule.branch}
          WORKING_DIRECTORY "${${name}.submodule.path}"
          OUTPUT_QUIET
          RESULT_VARIABLE failure
          ERROR_VARIABLE error_output)

        if(failure)
          message(FATAL ${error_output})
        endif()

        set(${name}.submodule.current_branch ${${name}.submodule.branch}
          CACHE INTERNAL
          "The ${name} git submodule branch currently checked out")
      endif()

      execute_process(
        COMMAND ${GIT_EXECUTABLE} pull
        WORKING_DIRECTORY "${${name}.submodule.path}"
        OUTPUT_QUIET
        RESULT_VARIABLE failure
        ERROR_VARIABLE error_output)

      if(failure)
        message(FATAL ${error_output})
      endif()

    else()
      if(${name}.submodule.current_branch)
        unset(${name}.submodule.current_branch CACHE)
      endif()

      if(NOT ${name}.submodule.current_hash STREQUAL ${name}.submodule.hash)
        execute_process(
          COMMAND ${GIT_EXECUTABLE} fetch
          COMMAND ${GIT_EXECUTABLE} checkout ${${name}.submodule.hash}
          WORKING_DIRECTORY "${${name}.submodule.path}"
          OUTPUT_QUIET
          RESULT_VARIABLE failure
          ERROR_VARIABLE error_output)

        if(failure)
          message(FATAL ${error_output})
        endif()

        set(${name}.submodule.current_hash ${${name}.submodule.hash}
          CACHE INTERNAL
          "The ${name} git submodule is in detached head mode")
      endif()

    endif()
  endfunction()

  set_property(
    GLOBAL PROPERTY git.submodule.update.cmake
    "This is a header guard")
endif()
