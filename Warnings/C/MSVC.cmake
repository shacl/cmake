add_library(warnings_C_MSVC INTERFACE)

target_compile_options(warnings_C_MSVC INTERFACE
  /Wall
  $<$<BOOL:$<TARGET_PROPERTY:werror>>:/WX>)

target_link_libraries(warnings_C INTERFACE
  $<$<C_COMPILER_ID:MSVC>:warnings_C_MSVC>)
