# Here we're using the existance of global properties to act as something
# analoguous to C/C++ header guards to ensure the contents of this file are not
# redundantly defined.

get_property(
  git.submodule.packages.cmake
  GLOBAL PROPERTY git.submodule.packages.cmake SET)

if(NOT git.submodule.packages.cmake)
  include(CMakeDependentOption)

  option(git.submodule.packages
    "Enable git submodule support for CMake package" ON)

  CMAKE_DEPENDENT_OPTION(
    git.submodule.update
    "Update git submodule packages tracking branches on configure" ON
    "git.submodule.packages" OFF)

  set(git.submodule.default_branch "master" CACHE STRING
    "if git.submodule.update is ON, <submodule>.submodule.branch will default to this value.")

  find_package(git REQUIRED)
  include(git/submodule/packages/collect_state)
  include(git/submodule/packages/init)
  include(git/submodule/packages/update)
  include(git/submodule/packages/list)
  include(git/submodule/packages/find_package)

  set_property(
    GLOBAL PROPERTY git.packages.list.cmake
    "This is a header guard")
endif()

git_submodule_list()
