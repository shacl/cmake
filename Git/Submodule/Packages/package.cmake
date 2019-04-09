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

  set(git.submodule.packages.subject "${name}")
  if("${ARGV1}" MATCHES "[0-9]+(\\.[0-9])*")
    set(PACKAGE_FIND_VERSION ${ARGV1})
    string(REPLACE "." ";" version_list "${PACKAGE_FIND_VERSION}")
    list(GET version_list 0 PACKAGE_FIND_VERSION_MAJOR)
    if(NOT PACKAGE_FIND_VERSION_MAJOR)
      set(PACKAGE_FIND_VERSION_MAJOR 0)
    endif()
    list(GET version_list 1 PACKAGE_FIND_VERSION_MINOR)
    if(NOT PACKAGE_FIND_VERSION_MINOR)
      set(PACKAGE_FIND_VERSION_MINOR 0)
    endif()
  else()
    set(PACKAGE_FIND_VERSION "")
    set(PACKAGE_FIND_VERSION_MAJOR "")
    set(PACKAGE_FIND_VERSION_MINOR "")
  endif()

  set(find_package_options EXACT QUIET REQUIRED)
  set(find_package_singleValueArgs)
  set(find_package_multipleValueArgs COMPONENTS OPTIONAL_COMPONENTS)

  cmake_parse_arguments(${name}_FIND
    "${find_package_options}"
    "${find_package_singleValueArgs}"
    "${find_package_multipleValueArgs}"
    ${ARGN})

  set(${name}_FIND_QUIETLY ${${name}_FIND_QUIET})
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
      set(${name}_FIND_REQUIRED_${component} TRUE)
    endif()
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
      set(${name}_FIND_REQUIRED_${component} FALSE)
    endif()
  endforeach()

  if(${name}_FIND_OPTIONAL_COMPONENTS)
    set(continue TRUE)
  endif()

  if(continue)
    list(APPEND ${name}_FIND_COMPONENTS ${${name}_FIND_OPTIONAL_COMPONENTS})

    set(git.submodule.package.PROJECT_VERSION 0.0.0)
    set(git.submodule.package.PROJECT_VERSION_MAJOR 0)
    set(git.submodule.package.PROJECT_VERSION_MINOR 0)
    add_subdirectory(
      "${git.submodule.packages.cache}/${name}"
      "${LIST_BINARY_DIR}/${name}")

    set(${name}_FOUND TRUE PARENT_SCOPE)
  endif()

  include(Git/Submodule/Packages/check_version)
endfunction()
