get_property(
  git.submodule.update.cmake
  GLOBAL PROPERTY git.submodule.update.cmake SET)

if(NOT git.submodule.update.cmake)
  function(git_submodule_update name)
    if(${name}.submodule.branch)
      if(NOT ${name}.on_branch)
        execute_process(
          COMMAND ${GIT_EXECUTABLE} checkout ${${name}.submodule.branch}
          WORKING_DIRECTORY "${PROJECT_SOURCE_DIR}")

        set(${name}.on_branch TRUE CACHE INTERAL
          "The ${name} git submodule branch has been checked out")
      endif()

      execute_process(
        COMMAND ${GIT_EXECUTABLE} fetch
        COMMAND ${GIT_EXECUTABLE} pull
        WORKING_DIRECTORY "${${name}.submodule.path}")

      execute_process(
        COMMAND ${GIT_EXECUTABLE} rev-parse HEAD
        WORKING_DIRECTORY "${${name}.submodule.path}"
        OUTPUT_VARIABLE hash)

      set(${name}.submodule.hash ${hash} CACHE STRING
        "${name} git submodule hash" FORCE)
    else()
      if(NOT ${name}.detached_head)
        execute_process(
          COMMAND ${GIT_EXECUTABLE} fetch
          COMMAND ${GIT_EXECUTABLE} checkout ${${name}.submodule.hash}
          WORKING_DIRECTORY "${${name}.submodule.path}")

        set(${name}.detached_head TRUE CACHE INTERAL
          "The ${name} git submodule is in detached head mode")
      endif()
    endif()
  endfunction()

  set_property(GLOBAL PROPERTY git.submodule.update.cmake "")
endif()
