find_package(Perl REQUIRED)

set(FPP_PATH ${CMAKE_CURRENT_LIST_DIR}/utils/fpp.pl CACHE string "path to F preprocessor")

function(FPreProcess infile outfile)
string(REPLACE ";" " -D" FPP_ARGS "-D${ARGN}")
add_custom_command(
  OUTPUT ${outfile}
  COMMAND ${PERL_EXECUTABLE} ${FPP_PATH} ${FPP_ARGS} -o ${outfile} -- ${infile}
  DEPENDS ${infile}
  WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
)
endfunction(FPreProcess)
