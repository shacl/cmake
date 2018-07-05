add_library(warnings_Fortran_GNU INTERFACE)

target_compile_options(warnings_Fortran_GNU INTERFACE
  -Wall
  -Wextra
  -Wpedantic
  -Wcharacter-truncation
  -Wrealloc-lhs
  -Wsurprising
  -Wuse-without-only
  $<$<BOOL:$<TARGET_PROPERTY:werror>>:-Werror;-Wno-error=realloc-lhs;>)

target_link_libraries(warnings_Fortran INTERFACE
  $<$<STREQUAL:${CMAKE_Fortran_COMPILER_ID},GNU>:warnings_Fortran_GNU>)
