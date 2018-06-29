add_library(warnings_C_LLVM INTERFACE)

target_compile_options(warnings_C_LLVM INTERFACE
  -Wall
  -Wextra
  -Wpedantic
  -Wassign-enum
  -Wbad-function-cast
  -Wkeyword-macro
  -Wnonportable-system-include-path
  -Wsometimes-uninitialized
  $<$<BOOL:$<TARGET_PROPERTY:werror>>:-Werror>)

target_link_libraries(warnings_C INTERFACE
  $<$<OR:$<C_COMPILER_ID:AppleClang>,$<C_COMPILER_ID:Clang>>:warnings_C_LLVM>)
