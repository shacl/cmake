option(git.submodule.packages
  "Enable git submodule support for CMake find_package" ON)

option(git.submodule.update
  "Update git submodule packages tracking branches on configure" ON)

set(git.submodule.default_branch "master" CACHE STRING
"Given `git.submodule.update` is ON and the absense of a \
<submodule>.submodule_hash specification, <submodule>.submodule_branch will \
default to this value.")

find_package(git REQUIRED)
include(git/submodule/list)
include(git/submodule/clone)
include(git/submodule/update)

function(find_package package)
  if(NOT TARGET ${ARG0})
    string(REPLACE ":" ";" name_list ${package})
    list(GET name_list -1 name)
    if(git.submodule.packages)
      list(FIND ${CMAKE_PROJECT_NAME}.submodules ${name} found_submodule)
      if(found_submodule GREATER "-1" AND ${name}.submodule)
        git_submodule_clone(${name})
        git_submodule_update(${name})
        add_subdirectory(${${name}.submodule_path})
        return()
      endif()
    endif()
  endif()

  _find_package(${ARGV})
endfunction()
