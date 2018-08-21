macro(find_package package)
  if((NOT ${package}.submodule)
      OR (NOT ${package} IN_LIST ${PROJECT_NAME}.submodules))
    previous_find_package(${ARGV})
    return()
  endif()

  if(NOT EXISTS "${${package}.submodule.path}/.git")
    git_submodule_init(${package})
    git_submodule_update(${package})
    if(NOT EXISTS "${${package}.submodule.path}/CMakeLists.txt")
      message("")
      message("=======================")
      message("git submodule package, ${package}, does not contain a CMakeLists.txt file")
      message("The ${package} git submodule is located here: ${${package}.submodule.path}")
      message("${package} requested with find_package by ${PROJECT_NAME}")
      message("${PROJECT_NAME} is located here: ${PROJECT_SOURCE_DIR}")
      message("=======================")
      message("")
      message(FATAL_ERROR " find_package request failed")
    endif()
  endif()

  if("${ARGV0}" MATCHES "[0-9]+(\\.[0-9])*")
    set(PACKAGE_FIND_VERSION ${ARGV0})
  endif()

  set(options EXACT QUIET REQUIRED)
  set(multiValueArgs COMPONENTS OPTIONAL_COMPONENTS)

  cmake_parse_arguments(${package}_FIND_
    "${options}" "" "${multiValueArgs}" ${ARGN})

  set(${package}_FIND_QUIETLY ${${package}_FIND_QUIET})

  foreach(component IN LISTS ${package}_FIND_COMPONENTS)
    set(${package}_FIND_REQUIRED_{component} TRUE)
  endforeach()

  list(APPEND ${package}_FIND_COMPONENTS ${${package}_FIND_OPTIONAL_COMPONENTS})
  file(RELATIVE_PATH stem ${CMAKE_SOURCE_DIR} ${${package}.submodule.path})

  get_property(git.submodules.traversed GLOBAL PROPERTY git.submodules.traversed)
  foreach(component IN LISTS ${package}_FIND_COMPONENTS)
    if(TARGET ${package}::${component})
      list(REMOVE_ITEM ${package}_FIND_COMPONENTS component)
    endif()
  endforeach()

  if(${package}_FIND_COMPONENTS
      OR NOT ${package} IN_LIST git.submodules.traversed)
    set_property(GLOBAL APPEND PROPERTY git.submodules.traversed ${package})
    add_subdirectory(${CMAKE_SOURCE_DIR}/${stem} ${CMAKE_BINARY_DIR}/${stem})
  endif()

  if(PACKAGE_FIND_VERSION)
    set(PACKAGE_VERSION_EXACT TRUE)
    set(PACKAGE_VERSION_COMPATIBLE TRUE)
    if(${package}_VERSION VERSION_EQUAL PACKAGE_FIND_VERSION)
    else()
      set(PACKAGE_VERSION_EXACT FALSE)
      if(PACKAGE_FIND_EXACT
          OR PACKAGE_FIND_VERSION VERSION_GREATER ${package}_VERSION)
        set(PACKAGE_VERSION_COMPATIBLE FALSE)
      endif()
    endif()

    set(${package}_FOUND ${PACKAGE_VERSION_COMPATIBLE})
    if(${package}_FIND_REQUIRED AND NOT ${package}_FOUND)
      if(PACKAGE_FIND_EXACT)
        message(FATAL_ERROR
          "${package} requires version ${PACKAGE_FIND_VERSION} but found version ${${package}_VERSION}")
      else()
        message(FATAL_ERROR
          "${package} requires version ${PACKAGE_FIND_VERSION} or later but found version ${${package}_VERSION}")
      endif()
    endif()
  else()
    set(${package}_FOUND TRUE)
  endif()
endmacro()

wrap_find_package()
