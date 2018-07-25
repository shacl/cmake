add_library(warnings_Fortran_Intel INTERFACE)

string(CONCAT generator
  "$<$<BOOL:$<TARGET_PROPERTY:WARN_ERROR>>"
   ":$<IF:$<PLATFORM_ID:Windows>"
        ",$<1:/warn$<1::>error;/warn$<1::>stderror>"
        ",$<1:-warn;error;-warn;stderror>"
     ">"
   ">"
  "$<$<BOOL:$<TARGET_PROPERTY:WARN_ALL>>"
   ":$<IF:$<PLATFORM_ID:Windows>"
        ",$<1:/warn$<1::>all>"
        ",$<1:-warn;all>"
     ">"
   ">;"
  "$<$<BOOL:$<TARGET_PROPERTY:INTEL_ENABLED_WARNINGS>>:"
    "$<IF:$<PLATFORM_ID:Windows>,/warn$<1::>,-warn;>"
    "$<JOIN:$<TARGET_PROPERTY:INTEL_ENABLED_WARNINGS>,$<COMMA>>>;"
  "$<$<BOOL:$<TARGET_PROPERTY:INTEL_DISABLED_WARNINGS>>:"
    "$<IF:$<PLATFORM_ID:Windows>,/nowarn$<1::>,-nowarn;>"
    "$<JOIN:$<TARGET_PROPERTY:INTEL_DISABLED_WARNINGS>,$<COMMA>>>;")

target_compile_options(warnings_Fortran INTERFACE
  $<$<STREQUAL:${CMAKE_Fortran_COMPILER_ID},Intel>:${generator}>)
