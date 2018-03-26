string(CONCAT generator
  "$<$<STREQUAL:Intel,${CMAKE_Fortran_COMPILER_ID}>:"
      "$<$<NOT:$<PLATFORM_ID:Windows>>:-free>"
          "$<$<PLATFORM_ID:Windows>:/free>>"
)          

target_compile_options(Fortran_FreeForm INTERFACE ${generator})
