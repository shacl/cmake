string(CONCAT generator
  "$<$<BOOL:$<TARGET_PROPERTY:WARN_ERROR>>"
   ":$<$<PLATFORM_ID:Windows>:/WX>"
    "$<$<NOT:<$<PLATFORM_ID:Windows>>:-Werror>"
   ">;"
  "$<$<BOOL:$<TARGET_PROPERTY:WARN_ALL>>"
   ":$<$<PLATFORM_ID:Windows>:/W3>"
    "$<$<NOT:$<PLATFORM_ID:Windows>>:-w3>"
   ">;"
  "$<$<BOOL:$<TARGET_PROPERTY:INTEL_ENABLED_WARNINGS>>"
   ":$<$<PLATFORM_ID:Windows>:/Qdiag-enable:>"
    "$<$<NOT:$<PLATFORM_ID:Windows>>:-diag-enable=>"
    "$<JOIN:$<TARGET_PROPERTY:INTEL_ENABLED_WARNINGS>,$<COMMA>>"
   ">;"
  "$<$<BOOL:$<TARGET_PROPERTY:INTEL_DISABLED_WARNINGS>>"
   ":$<$<PLATFORM_ID:Windows>:/Qdiag-disable:>"
    "$<$<NOT:$<PLATFORM_ID:Windows>>:-diag-disable=>"
    "$<JOIN:$<TARGET_PROPERTY:INTEL_DISABLED_WARNINGS>,$<COMMA>>"
   ">;")

target_compile_options(warnings_C INTERFACE
  $<$<C_COMPILER_ID:Intel>:${generator}>)
