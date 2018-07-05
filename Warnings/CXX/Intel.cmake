add_library(warnings_CXX_Intel INTERFACE)
target_link_libraries(warnings_CXX_Intel INTERFACE warnings_C_Intel)
target_link_libraries(warnings_CXX INTERFACE
  $<$<CXX_COMPILER_ID:Intel>:warnings_CXX_Intel>)
