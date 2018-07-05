add_library(warnings_CXX_LLVM INTERFACE)

target_compile_options(warnings_CXX_LLVM INTERFACE
  -Wold-style-cast
  -Wnon-virtual-dtor
  -Wrange-loop-analysis
  -Wredundant-move)

target_link_libraries(warnings_CXX_LLVM INTERFACE warnings_C_LLVM)
target_link_libraries(warnings_CXX INTERFACE
  $<$<OR:$<C_COMPILER_ID:AppleClang>,$<C_COMPILER_ID:Clang>>:warnings_CXX_LLVM>)
