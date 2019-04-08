function(git_submodule_package name)
  if(NOT git.submodule.package.${name})
    if(NOT DEFINED git.submodule.package.${name})
      message(INFO "git_submodule_package called on package without a corresponding submodule in the repository")
      message(INFO "requested package: ${name}")
      message(FATAL_ERROR "No corresponding git submodule")
    else()
      message(INFO "git_submodule_package called on disabled package")
      message(INFO "requested package: ${name}")
      message(INFO "git.submodule.package.${name} cache entry: ${git.submodule.package.${name}}")
      message(FATAL_ERROR "Disabled git submodule package")
    endif()
  endif()

  if("${ARGV1}" MATCHES "[0-9]+(\\.[0-9])*")
    set(PACKAGE_FIND_VERSION ${ARGV1})
    string(FIND "${ARGV1}" "." truncate_point)
    string(SUBSTRING "${ARGV1}" 0 ${truncate_point} PACKAGE_FIND_VERSION_MAJOR)
  else()
    set(PACKAGE_FIND_VERSION "")
    set(PACKAGE_FIND_VERSION_MAJOR "")
  endif()

  set(find_package_options EXACT QUIET REQUIRED)
  set(find_package_singleValueArgs)
  set(find_package_multipleValueArgs COMPONENTS OPTIONAL_COMPONENTS)

  cmake_parse_arguments(${name}_FIND
    "${find_package_options}"
    "${find_package_singleValueArgs}"
    "${find_package_multipleValueArgs}"
    ${ARGN})

  set(continue FALSE)

  get_property(git.submodules.package.${name}.traversed GLOBAL PROPERTY
    git.submodules.package.${name}.traversed)

  if(NOT git.submodules.package.${name}.traversed)
    set_property(GLOBAL PROPERTY git.submodules.${name}.traversed TRUE)
    git_submodule_init(${name})
    git_submodule_update(${name})
    set(continue TRUE)
  endif()

  get_property(git.submodules.package.${name}.traversed.components
    GLOBAL PROPERTY git.submodules.package.${name}.traversed.components)

  foreach(component IN LISTS ${name}_FIND_COMPONENTS)
    if(component IN_LIST git.submodules.${name}.traversed.components)
      list(REMOVE_ITEM ${name}_FIND_COMPONENTS component)
    else()
      set_property(GLOBAL APPEND PROPERTY
        git.submodules.${name}.traversed.component ${component})
    endif()

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

    set(${name}_FIND_REQUIRED_${component} FALSE)
  endforeach()

  if(${name}_FIND_OPTIONAL_COMPONENTS)
    set(continue TRUE)
  endif()

  if(continue)
    list(APPEND ${name}_FIND_COMPONENTS ${${name}_FIND_OPTIONAL_COMPONENTS})
    add_subdirectory(
      "${git.submodule.packages.cache}/${name}"
      "${LIST_BINARY_DIR}/${name}")

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
  endif()
endfunction()
