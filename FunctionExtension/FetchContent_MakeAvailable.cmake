macro(previous_FetchContent_MakeAvailable)
  if(NOT previous_FetchContent_MakeAvailable_fn)
    set(previous_FetchContent_MakeAvailable_fn FetchContent_MakeAvailable)
  endif()

  push(previous_FetchContent_MakeAvailable_fn)

  set(previous_FetchContent_MakeAvailable_fn _${previous_FetchContent_MakeAvailable_fn})

  call(${previous_FetchContent_MakeAvailable_fn} ${ARGN})

  pop(previous_FetchContent_MakeAvailable_fn)
endmacro()
