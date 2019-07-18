macro(call function_name)
  push(indirection_file)
  set(indirection_file "${CMAKE_CURRENT_BINARY_DIR}/indirection")
  while(EXISTS "${indirection_file}.cmake")
    set(indirection_file "${indirection_file}_")
  endwhile()
  set(indirection_file "${indirection_file}.cmake")

  push(argn)
  push(call.argument)
  push(call.arguments)
  set(argn "${ARGN}")
  set(call.arguments)

  foreach(call.argument IN LISTS argn)
    set(call.arguments "${call.arguments} ${call.argument}")
  endforeach()
  pop(argn)
  pop(call.argument)

  file(WRITE "${indirection_file}" "${function_name}(${call.arguments})")

  pop(call.arguments)


  include("${indirection_file}")
  file(REMOVE "${indirection_file}")
  pop(indirection_file)
endmacro()
