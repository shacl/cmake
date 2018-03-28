string(CONCAT generator
  "$<$<STREQUAL:Intel,${CMAKE_Fortran_COMPILER_ID}>:"
      "$<$<NOT:$<PLATFORM_ID:Windows>>:-traceback>"
          "$<$<PLATFORM_ID:Windows>:/traceback>>"
)          

target_compile_options(Fortran_Backtrace INTERFACE ${generator})
