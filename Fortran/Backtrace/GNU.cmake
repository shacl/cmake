string(CONCAT generator
  "$<$<STREQUAL:GNU,${CMAKE_Fortran_COMPILER_ID}>"
   ":$<IF:$<BOOL:$<TARGET_PROPERTY:Fortran_BACKTRACE>>"
        ",-fbacktrace;"
        ",-fno-backtrace;"
     ">"
   ">")

target_compile_options(Fortran_Backtrace INTERFACE ${generator})
