option(git.submodule.packages ON)

include(git/submodule/list)
include(git/submodule/clone)

function(find_package)
  if(NOT TARGET ${ARG1})
    if(git.submodule.packages)
      list(FIND ${CMAKE_PROJECT_NAME}_submodules ${ARG1} found_submodule)
      if(${ARG1}_submodule)

        if(NOT ${ARG1}_submodule_cloned)
          clone_submodule(${ARG1})
          set(${ARG1}_submodule_cloned
            TRUE CACHE INTERNAL
            "${ARG1} git submodule has been cloned.")
        endif()

        add_subdirectory(${${ARG1}_path})
        return()
      endif()
    endif()
  endif()

  _find_package(${ARGV})
function()
