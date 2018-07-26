string(CONCAT generator
  "$<$<BOOL:$<TARGET_PROPERTY:WARN_ERROR>>"
   ":$<IF:$<PLATFORM_ID:Windows>,/WX,-Werror>>;"
  "$<$<BOOL:$<TARGET_PROPERTY:WARN_ALL>>"
   ":$<IF:$<PLATFORM_ID:Windows>,/W3,-w3>>;"
  "$<$<BOOL:$<TARGET_PROPERTY:INTEL_ENABLED_WARNINGS>>"
   ":$<IF:$<PLATFORM_ID:Windows>,/Qdiag-enable$<1::>,-diag-enable=>"
    "$<JOIN:$<TARGET_PROPERTY:INTEL_ENABLED_WARNINGS>,$<COMMA>>>;"
  "$<$<BOOL:$<TARGET_PROPERTY:INTEL_DISABLED_WARNINGS>>"
   ":$<IF:$<PLATFORM_ID:Windows>,/Qdiag-disable$<1::>,-diag-disable=>"
   "$<JOIN:$<TARGET_PROPERTY:INTEL_DISABLED_WARNINGS>,$<COMMA>>>;")

target_compile_options(warnings_CXX INTERFACE
  $<$<CXX_COMPILER_ID:Intel>:${generator}>)
