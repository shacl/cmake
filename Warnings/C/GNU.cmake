add_library(warnings_C_GNU INTERFACE)

target_compile_options(warnings_C_GNU INTERFACE
  -Wall
  -Wextra
  -Wpedantic
  -Wduplicated-branches
  -Wduplicated-cond
  $<$<BOOL:$<TARGET_PROPERTY:werror>>:-Werror>)

target_link_libraries(warnings_C INTERFACE
  $<$<C_COMPILER_ID:GNU>:warnings_C_GNU>)
