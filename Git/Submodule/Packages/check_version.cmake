get_property(${git.submodule.packages.subject}_VERSION GLOBAL PROPERTY
  ${git.submodule.packages.subject}_VERSION DEFINED)

if(NOT ${git.submodule.packages.subject}_VERSION)
  set(${git.submodule.packages.subject}_VERSION
    "${git.submodule.package.PROJECT_VERSION}")
  set_property(GLOBAL PROPERTY ${git.submodule.packages.subject}_VERSION
    "${${git.submodule.packages.subject}_VERSION}")

  set(${git.submodule.packages.subject}_VERSION_MAJOR
    "${git.submodule.package.PROJECT_VERSION_MAJOR}")
  set_property(GLOBAL PROPERTY ${git.submodule.packages.subject}_VERSION_MAJOR
    "${${git.submodule.packages.subject}_VERSION_MAJOR}")

  set(${git.submodule.packages.subject}_VERSION_MINOR
    "${git.submodule.package.PROJECT_VERSION_MINOR}")
  set_property(GLOBAL PROPERTY ${git.submodule.packages.subject}_VERSION_MINOR
    "${${git.submodule.packages.subject}_VERSION_MINOR}")

  set(${git.submodule.packages.subject}_VERSION_PATCH
    "${git.submodule.package.PROJECT_VERSION_PATCH}")
  set_property(GLOBAL PROPERTY ${git.submodule.packages.subject}_VERSION_PATCH
    "${${git.submodule.packages.subject}_VERSION_PATCH}")

  set(${git.submodule.packages.subject}_VERSION_TWEAK
    "${git.submodule.package.PROJECT_VERSION_TWEAK}")
  set_property(GLOBAL PROPERTY ${git.submodule.packages.subject}_VERSION_TWEAK
    "${${git.submodule.packages.subject}_VERSION_TWEAK}")

  pop(git.submodule.package.PROJECT_VERSION)
  pop(git.submodule.package.PROJECT_VERSION_MAJOR)
  pop(git.submodule.package.PROJECT_VERSION_MINOR)
  pop(git.submodule.package.PROJECT_VERSION_PATCH)
  pop(git.submodule.package.PROJECT_VERSION_TWEAK)
else()
  get_property(${git.submodule.packages.subject}_VERSION GLOBAL PROPERTY
    ${git.submodule.packages.subject}_VERSION)
  get_property(${git.submodule.packages.subject}_VERSION_MAJOR GLOBAL PROPERTY
    ${git.submodule.packages.subject}_VERSION_MAJOR)
  get_property(${git.submodule.packages.subject}_VERSION_MINOR GLOBAL PROPERTY
    ${git.submodule.packages.subject}_VERSION_MINOR)
  get_property(${git.submodule.packages.subject}_VERSION_PATCH GLOBAL PROPERTY
    ${git.submodule.packages.subject}_VERSION_PATCH)
  get_property(${git.submodule.packages.subject}_VERSION_TWEAK GLOBAL PROPERTY
    ${git.submodule.packages.subject}_VERSION_TWEAK)
endif()

if(PACKAGE_FIND_VERSION)
  push(PACKAGE_VERSION_EXACT)
  set(PACKAGE_VERSION_EXACT TRUE)

  push(PACKAGE_VERSION_COMPATIBLE)
  set(PACKAGE_VERSION_COMPATIBLE TRUE)

  push(git.submodule.package.CVF_COMPATIBILITY)
  get_property(
    git.submodule.package.CVF_COMPATIBILITY
    GLOBAL PROPERTY
    git.submodule.package.CVF_COMPATIBILITY)

  if(NOT ${git.submodule.packages.subject}_VERSION VERSION_EQUAL PACKAGE_FIND_VERSION)
    set(PACKAGE_VERSION_EXACT FALSE)
    if(${git.submodule.packages.subject}_FIND_EXACT)
      string(CONCAT message
        "${git.submodule.packages.subject} version ${PACKAGE_FIND_VERSION} (exactly) requested\n"
        "Found version ${${git.submodule.packages.subject}_VERSION} via submodule\n"
        "Please update the ${git.submodule.packages.subject} repository located at: "
        "${git.submodule.packages.cache}/${git.submodule.packages.subject}\n")
      message(FATAL_ERROR "${message}")
    elseif(${git.submodule.packages.subject}_VERSION VERSION_LESS PACKAGE_FIND_VERSION)
      string(CONCAT message
        "${git.submodule.packages.subject} version ${PACKAGE_FIND_VERSION} requested\n"
        "Found version ${${git.submodule.packages.subject}_VERSION} via submodule\n"
        "Please update the ${git.submodule.packages.subject} repository located at: "
        "${git.submodule.packages.cache}/${git.submodule.packages.subject}\n")
      message(FATAL_ERROR "${message}")
    elseif(git.submodule.package.CVF_COMPATIBILITY STREQUAL "ExactVersion")
      string(CONCAT message
        "${git.submodule.packages.subject} version ${PACKAGE_FIND_VERSION} requested\n"
        "Found version ${${git.submodule.packages.subject}_VERSION} via submodule\n"
        "${git.submodule.packages.subject} only provides compatibility within the same exact version\n"
        "Please update the ${git.submodule.packages.subject} repository located at: "
        "${git.submodule.packages.cache}/${git.submodule.packages.subject}\n")
      message(FATAL_ERROR "${message}")
    elseif(git.submodule.package.CVF_COMPATIBILITY STREQUAL "SameMajorVersion")
      if(NOT ${git.submodule.packages.subject}_VERSION_MAJOR EQUAL PACKAGE_FIND_VERSION_MAJOR)
        string(CONCAT message
          "${git.submodule.packages.subject} version ${PACKAGE_FIND_VERSION} requested\n"
          "Found version ${${git.submodule.packages.subject}_VERSION} via submodule\n"
          "${git.submodule.packages.subject} only provides compatibility within the same major version\n"
          "Please update the ${git.submodule.packages.subject} repository located at: "
          "${git.submodule.packages.cache}/${git.submodule.packages.subject}\n")
        message(FATAL_ERROR "${message}")
      endif()
    elseif(git.submodule.package.CVF_COMPATIBILITY STREQUAL "SameMinorVersion")
      if(NOT ${git.submodule.packages.subject}_VERSION_MINOR EQUAL PACKAGE_FIND_VERSION_MINOR)
        string(CONCAT message
          "${git.submodule.packages.subject} version ${PACKAGE_FIND_VERSION} requested\n"
          "Found version ${${git.submodule.packages.subject}_VERSION} via submodule\n"
          "${git.submodule.packages.subject} only provides compatibility within the same minor version\n"
          "Please update the ${git.submodule.packages.subject} repository located at: "
          "${git.submodule.packages.cache}/${git.submodule.packages.subject}\n")
        message(FATAL_ERROR "${message}")
      endif()
    endif()
  endif()
  pop(git.submodule.package.CVF_COMPATIBILITY)
  pop(PACKAGE_VERSION_COMPATIBLE)
  pop(PACKAGE_VERSION_EXACT)
endif()
