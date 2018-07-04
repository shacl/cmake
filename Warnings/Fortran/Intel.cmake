add_library(warnings_Fortran_Intel INTERFACE)

string(CONCAT generator
  "$<IF:$<PLATFORM_ID:Windows>"
      ",$<1:/W1;/warn:all>"
      ",$<1:-W1;-warn;all>"
   ">;"
  "$<$<BOOL:$<TARGET_PROPERTY:werror>>"
   ":$<IF:$<PLATFORM_ID:Windows>,"
         "$<1:/warn:error;/warn:stderror>,"
         "$<1:-warn error;-warn stderror>>>")

target_compile_options(warnings_Fortran_Intel INTERFACE ${generator})

target_link_libraries(warnings_Fortran INTERFACE
  $<$<STREQUAL:${CMAKE_Fortran_COMPILER_ID},Intel>:warnings_Fortran_Intel>)
