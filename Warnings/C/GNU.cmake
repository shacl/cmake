add_library(warnings_C_GNU INTERFACE)

target_compile_options(warnings_C_GNU INTERFACE
  -Wall
  -Wextra
  -Wpedantic
  $<$<VERSION_GREATER:$<CXX_COMPILER_VERSION>,7.0>:-Wduplicated-branches>
  $<$<VERSION_GREATER:$<CXX_COMPILER_VERSION>,6.0>:-Wduplicated-cond>
  $<$<BOOL:$<TARGET_PROPERTY:werror>>:-Werror>)

target_link_libraries(warnings_C INTERFACE
  $<$<C_COMPILER_ID:GNU>:warnings_C_GNU>)
