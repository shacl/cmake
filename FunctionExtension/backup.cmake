macro(backup func)
  if(COMMAND _${func})
    backup(_${func})
  endif()
  macro(_${func})
  endmacro()
endmacro()
