cmake_minimum_required(VERSION 3.12.1)
macro(previous_add_library)
  if(NOT previous_add_library_fn)
    set(previous_add_library_fn add_library)
  endif()

  push(previous_add_library_fn)
  set(previous_add_library_fn _${previous_add_library_fn})
  call(${previous_add_library_fn} "${ARGN}")
  pop(previous_add_library_fn)
endmacro()
