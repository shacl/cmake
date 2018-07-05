add_library(warnings_CXX_GNU INTERFACE)

target_compile_options(warnings_CXX_GNU INTERFACE
  -Wold-style-cast
  -Wsuggest-override)

target_link_libraries(warnings_CXX_GNU INTERFACE warnings_C_GNU)
target_link_libraries(warnings_CXX INTERFACE
  $<$<CXX_COMPILER_ID:GNU>:warnings_CXX_GNU>)
