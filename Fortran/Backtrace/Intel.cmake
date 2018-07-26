string(CONCAT generator
  "$<$<STREQUAL:Intel,${CMAKE_Fortran_COMPILER_ID}>"
   ":$<IF:$<BOOL:$<TARGET_PROPERTY:Fortran_BACKTRACE>>"
        ",$<IF:$<PLATFORM_ID:Windows>"
             ",/traceback;"
             ",-traceback;"
          ">"
        ",$<IF:$<PLATFORM_ID:Windows>"
             ",/notraceback;"
             ",-notraceback;"
          ">"
     ">"
   ">")

target_compile_options(Fortran_Backtrace INTERFACE ${generator})
