macro(previous_FetchContent_Declare)
  if(NOT previous_FetchContent_Declare_fn)
    set(previous_FetchContent_Declare_fn FetchContent_Declare)
  endif()

  push(previous_FetchContent_Declare_fn)

  set(previous_FetchContent_Declare_fn _${previous_FetchContent_Declare_fn})

  call(${previous_FetchContent_Declare_fn} ${ARGN})

  pop(previous_FetchContent_Declare_fn)
endmacro()
