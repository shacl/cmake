add_library(warnings_Fortran_Intel INTERFACE)

string(CONCAT generator
  "$<IF:$<PLATFORM_ID:Windows>,/W3,-w3>;"
  "$<$<BOOL:$<TARGET_PROPERTY:werror>>"
   ":$<PLATFORM_ID:Windows>,/WX,-Werror>;")

target_compile_options(warnings_Fortran_Intel INTERFACE ${generator})

target_link_libraries(warnings_Fortran INTERFACE
  $<$<STREQUAL:${CMAKE_Fortran_COMPILER_ID},Intel>:warnings_Fortran_Intel>)
