# Here we're using the existance of global properties to act as something
# analoguous to C/C++ header guards to ensure the contents of this file are not
# redundantly defined.

get_property(
  git.submodule.packages.find_package.cmake
  GLOBAL PROPERTY git.submodule.packages.find_package.cmake SET)

if(NOT git.submodule.packages.find_package.cmake)
  function(find_package package)
    if(${package}_FOUND)
      return()
    endif()
    if(git.submodule.packages)
      list(FIND ${CMAKE_PROJECT_NAME}.submodules ${package} found_submodule)
      if(found_submodule GREATER "-1" AND ${package}.submodule)
        git_submodule_init(${package})
        git_submodule_update(${package})
        if(NOT EXISTS ${${package}.submodule.path}/CMakeLists.txt)
          message("")
          message("=======================")
          message("git submodule package, ${package}, does not contain a CMakeLists.txt file")
          message("The ${package} git submodule is located here: ${${package}.submodule.path}")
          message("${package} requested with find_package by ${CMAKE_PROJECT_NAME}")
          message("${CMAKE_PROJECT_NAME} is located here: ${PROJECT_SOURCE_DIR}")
          message("=======================")
          message("")
          message(FATAL_ERROR " find_package request failed")
        endif()
        add_subdirectory(${${package}.submodule.path})
        set(${package}_FOUND TRUE)
        return()
      endif()
    endif()

    previous_find_package(${ARGV})
  endfunction()

  wrap_find_package()

  set_property(
    GLOBAL PROPERTY git.submodule.packages.find_package.cmake
    "This is a header guard")
endif()
