string(CONCAT generator
  "$<$<STREQUAL:Intel,${CMAKE_Fortran_COMPILER_ID}>:"
      "$<$<NOT:$<PLATFORM_ID:Windows>>:-stand;f08>"
          "$<$<PLATFORM_ID:Windows>:/stand:f08>>"
)          

target_compile_options(Fortran_Standard2008 INTERFACE ${generator})
