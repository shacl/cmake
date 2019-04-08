cmake_minimum_required(VERSION 3.12.1)
backup(find_package)

macro(find_package name)
  #
  # git.submodule.package.<name> is dependent on git.submodule.package. Isn't
  # the check of the git.submodule.package redundant?
  #
  # In a perfect world, it would be. Unfortunately, the dispatching
  # implementation for dependent options, variables, and selections is based
  # on the way directory scope variables shadow and hide cache variables.
  #
  # A consequence of this trivia is that, should a sibling dependencies include
  # a shared dependency, with and without including the Git Submodule Packages
  # module, the cache variable will be read by one and the directory variable
  # by the other, leading to contradictory paths.
  #
  if(NOT (git.submodule.packages AND git.submodule.package.${name}))
    previous_find_package(${ARGV})
    return()
  endif()

  push(PACKAGE_FIND_VERSION)
  push(PACKAGE_FIND_VERSION_MAJOR)
  if("${ARGV1}" MATCHES "[0-9]+(\\.[0-9])*")
    set(PACKAGE_FIND_VERSION ${ARGV1})
    push(truncate_point)
    string(FIND "${ARGV1}" "." truncate_point)
    string(SUBSTRING "${ARGV1}" 0 ${truncate_point} PACKAGE_FIND_VERSION_MAJOR)
    pop(truncate_point)
  else()
    set(PACKAGE_FIND_VERSION "")
    set(PACKAGE_FIND_VERSION_MAJOR "")
  endif()

  push(find_package_options)
  set(find_package_options EXACT QUIET REQUIRED)

  push(find_package_multiValueArgs)
  set(find_package_multiValueArgs COMPONENTS OPTIONAL_COMPONENTS)

  push(${name}_FIND_EXACT)
  push(${name}_FIND_QUIET)
  push(${name}_FIND_REQUIRED)
  push(${name}_FIND_COMPONENTS)
  push(${name}_FIND_OPTIONAL_COMPONENTS)

  cmake_parse_arguments(${name}_FIND
    "${find_package_options}" "" "${find_package_multiValueArgs}" ${ARGN})

  pop(find_package_options)
  pop(find_package_multiValueArgs)

  push(${name}_FIND_QUIETLY)
  set(${name}_FIND_QUIETLY ${${name}_FIND_QUIET})

  if(NOT DEFINED git.submodule.packages.quiet.${name})
    set(git.submodule.packages.quiet.${name} ${${name}_FIND_QUIET})
  endif()

  set(${name}_FOUND FALSE)

  push(continue)
  set(continue TRUE)

  push(eager)
  set(eager "${git.submodule.package.${name}.eager}")
  if(eager STREQUAL "default")
    set(eager "${git.submodule.packages.eager}")
  endif()

  if(NOT eager)
    push(EXACT_ARG)
    if(${name}_FIND_EXACT)
      set(EXACT_ARG EXACT)
    else()
      set(EXACT_ARG "")
    endif()

    push(COMPONENTS_ARG)
    if(${name}_FIND_COMPONENTS)
      set(COMPONENTS_ARG COMPONENTS ${${name}_FIND_COMPONENTS})
    else()
      set(COMPONENTS_ARG)
    endif()

    push(OPTIONAL_COMPONENTS_ARG)
    if(${name}_FIND_OPTIONAL_COMPONENTS)
      set(OPTIONAL_COMPONENTS_ARG
        OPTIONAL_COMPONENTS ${${name}_FIND_OPTIONAL_COMPONENTS})
    else()
      set(OPTIONAL_COMPONENTS_ARG)
    endif()

    previous_find_package(${name}
      ${PACKAGE_FIND_VERSION} ${EXACT_ARG}
      QUIET
      ${COMPONENTS_ARG}
      ${OPTIONAL_CONPONENT_ARG})

    pop(EXACT_ARG)
    pop(COMPONENTS_ARG)
    pop(OPTIONAL_COMPONENTS_ARG)

    if(${name}_FOUND)
      set(continue FALSE)
    endif()
  endif()

  if(continue)
    push(git.submodules.package.${name}.traversed)
    get_property(git.submodules.package.${name}.traversed GLOBAL PROPERTY
      git.submodules.package.${name}.traversed)
    if(NOT git.submodules.package.${name}.traversed)
      set_property(GLOBAL PROPERTY git.submodules.${name}.traversed TRUE)
      set(continue TRUE)
    endif()

    push(git.submodules.package.${name}.traversed.components)
    get_property(git.submodules.package.${name}.traversed.components
      GLOBAL PROPERTY git.submodules.package.${name}.traversed.components)

    foreach(component IN LISTS ${name}_FIND_COMPONENTS)
      if(component IN_LIST git.submodules.${name}.traversed.components)
        list(REMOVE_ITEM ${name}_FIND_COMPONENTS component)
      else()
        set_property(GLOBAL APPEND PROPERTY
          git.submodules.${name}.traversed.component ${component})
      endif()

      push(${name}_FIND_REQUIRED_${component})
      set(${name}_FIND_REQUIRED_${component} TRUE)
    endforeach()

    if(${name}_FIND_COMPONENTS)
      set(continue TRUE)
    endif()

    foreach(component IN LISTS ${name}_FIND_OPTIONAL_COMPONENTS)
      if(component IN_LIST git.submodules.${name}.traversed.components)
        list(REMOVE_ITEM ${name}_FIND_OPTIONAL_COMPONENTS component)
      else()
        set_property(GLOBAL APPEND PROPERTY
          git.submodules.${name}.traversed.component ${component})
      endif()

      push(${name}_FIND_REQUIRED_${component})
      set(${name}_FIND_REQUIRED_${component} FALSE)
    endforeach()

    if(${name}_FIND_OPTIONAL_COMPONENTS)
      set(continue TRUE)
    endif()

    pop(git.submodules.package.${name}.traversed.components)

    if(continue)
      if((NOT eager) AND (NOT git.submodule.packages.quiet.${name}))
        message(STATUS "Failed to find local installation of ${name}.")
      endif()

      if(NOT git.submodules.package.${name}.traversed)
        git_submodule_init(${name} ${git.submodule.packages.quiet.${name}})
        git_submodule_update(${name} ${git.submodule.packages.quiet.${name}})
      endif()

      push(ALL_COMPONENTS)
      set(ALL_COMPONENTS "")
      list(APPEND ALL_COMPONENTS
        ${${name}_FIND_COMPONENTS}
        ${${name}_FIND_OPTIONAL_COMPONENTS})

      push(${name}_FIND_COMPONENTS)
      set(${name}_FIND_COMPONENTS ${ALL_COMPONENTS})
      pop(ALL_COMPONENTS)

      add_subdirectory(
        "${git.submodule.packages.cache}/${name}"
        "${CMAKE_CURRENT_BINARY_DIR}/${name}")

      pop(${name}_FIND_COMPONENTS)
      if(PACKAGE_FIND_VERSION)
        set(PACKAGE_VERSION_EXACT TRUE)
        set(PACKAGE_VERSION_COMPATIBLE TRUE)
        if(NOT ${name}_VERSION VERSION_EQUAL PACKAGE_FIND_VERSION)
          set(PACKAGE_VERSION_EXACT FALSE)
          if(PACKAGE_FIND_EXACT)
            string(CONCAT message
              "${name} requires version ${PACKAGE_FIND_VERSION}\n"
              "Found version ${${name}_VERSION} via submodule\n"
              "\n"
              "Please update the ${name} repository located at:\n"
              "${git.submodule.packages.cache}/${name}")
            message(FATAL_ERROR "${message}")
          elseif(PACKAGE_FIND_VERSION VERSION_GREATER ${name}_VERSION)
            string(CONCAT message
              "${name} requires version ${PACKAGE_FIND_VERSION} or later\n"
              "Found version ${${name}_VERSION} via submodule\n"
              "\n"
              "Please update the ${name} repository located at:\n"
              "${git.submodule.packages.cache}/${name}")
            message(FATAL_ERROR "${message}")
          elseif(NOT PACKAGE_FIND_VERSION_MAJOR EQUAL ${name}_VERSION_MAJOR)
            string(CONCAT message
              "${name} requires version ${PACKAGE_FIND_VERSION_MAJOR}\n"
              "Found version ${${name}_VERSION_MAJOR} via submodule\n"
              "\n"
              "Please update the ${name} repository located at:\n"
              "${git.submodule.packages.cache}/${name}")
            message(FATAL_ERROR "${message}")
          endif()
        endif()
      endif()
      set(${name}_FOUND TRUE)
    endif()
    pop(git.submodules.package.${name}.traversed)
  endif()
  pop(continue)
  pop(eager)

  foreach(component IN LISTS ${package}_FIND_COMPONENTS)
    pop(${name}_FIND_REQUIRED_{component})
  endforeach()
  pop(${name}_FIND_COMPONENTS)

  foreach(component IN LISTS ${package}_FIND_OPTIONAL_COMPONENTS)
    pop(${package}_FIND_REQUIRED_{component})
  endforeach()
  pop(${name}_FIND_OPTIONAL_COMPONENTS)

  pop(PACKAGE_VERSION_COMPATIBLE)
  pop(PACKAGE_VERSION_EXACT)
  pop(${package}_FIND_QUIETLY)
  pop(${package}_FIND_REQUIRED)
  pop(${package}_FIND_QUIET)
  pop(${package}_FIND_EXACT)
  pop(PACKAGE_FIND_VERSION)
endmacro()
