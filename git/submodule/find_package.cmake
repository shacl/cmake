# Here we're using the existance of global properties to act as something
# analoguous to C/C++ header guards to ensure the contents of this file are not
# redundantly defined.

get_property(
  git.submodule.find_package.cmake
  GLOBAL PROPERTY git.submodule.find_package.cmake SET)

if(NOT git.submodule.find_package.cmake)

  function(find_package package)
    if(NOT TARGET ${ARG0})
      string(REPLACE ":" ";" name_list ${package})
      list(GET name_list -1 name)
      if(git.submodule.packages)
        list(FIND ${CMAKE_PROJECT_NAME}.submodules ${name} found_submodule)
        if(found_submodule GREATER "-1" AND ${name}.submodule)
          git_submodule_init(${name})
          git_submodule_update(${name})
          add_subdirectory(${${name}.submodule.path})
          return()
        endif()
      endif()
    endif()

    _find_package(${ARGV})
  endfunction()

  set_property(
    GLOBAL PROPERTY git.submodule.find_package.cmake
    "This is a header guard")
endif()
