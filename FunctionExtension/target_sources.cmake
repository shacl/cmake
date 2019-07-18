macro(previous_target_sources)
  if(NOT previous_target_sources_fn)
    set(previous_target_sources_fn target_sources)
  endif()
  push(previous_target_sources_fn)
  set(previous_target_sources_fn _${previous_target_sources_fn})

  push(target_sources.arguments)
  push(target_sources.argument)
  push(argv)

  set(argv "${ARGV}")
  set(target_sources.arguments)
  foreach(target_sources.argument IN LISTS argv)
    if(target_sources.argument MATCHES ".*[ ].*"
        AND NOT target_sources.argument MATCHES "\".*\"")
      list(APPEND target_sources.arguments
        "\"${target_sources.argument}\"")
    else()
      list(APPEND target_sources.arguments
        "${target_sources.argument}")
    endif()
  endforeach()

  call(${previous_target_sources_fn} ${target_sources.arguments})

  pop(argv)
  pop(target_sources.argument)
  pop(target_sources.arguments)
  pop(previous_target_sources_fn)
endmacro()
