add_library(warnings_Fortran_Intel INTERFACE)

string(CONCAT generator
  "$<IF:$<PLATFORM_ID:Windows>"
      ",/warn$<1::>"
      ",-warn;"
   ">")

string(CONCAT generator
  "$<$<BOOL:$<TARGET_PROPERTY:WARN_ERROR>>"
   ":${generator}error$<COMMA>stderror"
   ">"
  "$<$<BOOL:$<TARGET_PROPERTY:WARN_ALL>>"
   ":$<IF:$<BOOL:$<TARGET_PROPERTY:WARN_ERROR>>"
        ",$<COMMA>"
        ",${generator}"
     ">"
     "all"
   ">;"
  "$<$<BOOL:$<TARGET_PROPERTY:INTEL_ENABLED_WARNINGS>>:"
    "$<IF:$<PLATFORM_ID:Windows>,/Qdiag-enable$<1::>,-diag-enable=>"
    "$<JOIN:$<TARGET_PROPERTY:INTEL_ENABLED_WARNINGS>,$<COMMA>>>;"
  "$<$<BOOL:$<TARGET_PROPERTY:INTEL_DISABLED_WARNINGS>>:"
    "$<IF:$<PLATFORM_ID:Windows>,/Qdiag-disable$<1::>,-diag-disable=>"
    "$<JOIN:$<TARGET_PROPERTY:INTEL_DISABLED_WARNINGS>,$<COMMA>>>;")

target_compile_options(warnings_Fortran INTERFACE
  $<$<STREQUAL:${CMAKE_Fortran_COMPILER_ID},Intel>:${generator}>)
