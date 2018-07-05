add_library(warnings_CXX_MSVC INTERFACE)

target_link_libraries(warnings_CXX_MSVC INTERFACE warnings_C_MSVC)
target_link_libraries(warnings_CXX INTERFACE
  $<$<CXX_COMPILER_ID:MSVC>:warnings_CXX_MSVC>)
