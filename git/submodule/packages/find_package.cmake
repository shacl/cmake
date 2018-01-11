# Here we're using the existance of global properties to act as something
# analoguous to C/C++ header guards to ensure the contents of this file are not
# redundantly defined.

get_property(
  git.submodule.packages.find_package.cmake
  GLOBAL PROPERTY git.submodule.packages.find_package.cmake SET)

if(NOT git.submodule.packages.find_package.cmake)

  backup(find_package)

  function(find_package package)
    if(NOT TARGET ${package})
      string(REPLACE ":" ";" name_list ${package})
      list(GET name_list -1 name)
      if(git.submodule.packages)
        list(FIND ${CMAKE_PROJECT_NAME}.submodules ${name} found_submodule)
        if(found_submodule GREATER "-1" AND ${name}.submodule)
          git_submodule_init(${name})
          git_submodule_update(${name})
          if(NOT EXISTS ${${name}.submodule.path}/CMakeLists.txt)
            message("")
            message("=======================")
            message("git submodule package, ${name}, does not contain a CMakeLists.txt file")
            message("The ${name} git submodule is located here: ${${name}.submodule.path}")
            message("${name} requested with find_package by ${CMAKE_PROJECT_NAME}")
            message("${CMAKE_PROJECT_NAME} is located here: ${PROJECT_SOURCE_DIR}")
            message("=======================")
            message("")
            message(FATAL_ERROR " find_package request failed")
          endif()
          add_subdirectory(${${name}.submodule.path})
          return()
        endif()
      endif()
    endif()

    previous_find_package(${ARGV})
  endfunction()

  set_property(
    GLOBAL PROPERTY git.submodule.packages.find_package.cmake
    "This is a header guard")
endif()
