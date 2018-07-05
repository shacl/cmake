add_library(warnings_C_Intel INTERFACE)

string(CONCAT generator
  "$<IF:$<PLATFORM_ID:Windows>,/W3,-w3>;"
  "$<$<BOOL:$<TARGET_PROPERTY:werror>>"
   ":$<PLATFORM_ID:Windows>,/WX,-Werror>;")

target_compile_options(warnings_C_Intel INTERFACE ${generator})

target_link_libraries(warnings_C INTERFACE
  $<$<C_COMPILER_ID:Intel>:warnings_C_Intel>)
