cmake_minimum_required(VERSION 3.12.1)
backup(add_executable)

macro(add_executable target_)
  push(scl.DependencyInjection.target)
  set(scl.DependencyInjection.target ${target_})

  previous_add_executable(${scl.DependencyInjection.target} "${ARGN}")

  foreach(inc IN LISTS ${scl.DependencyInjection.target}.injections)
    include(${inc})
  endforeach()

  pop(scl.DependencyInjection.target)
endmacro()

install(FILES
  ${CMAKE_CURRENT_LIST_DIR}/add_executable.cmake
  DESTINATION share/cmake/shacl/.cmake/DependencyInjection)
