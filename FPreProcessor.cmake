find_package(Perl REQUIRED)

set(FPP_PATH ${CMAKE_CURRENT_LIST_DIR}/utils/fpp.pl CACHE string "path to F preprocessor")

function(FPreProcess infile outfile)
  foreach(arg ${ARGN})
    if(arg STREQUAL "DEFINE")
      set(keyword "DEFINE")
    elseif(arg STREQUAL "UNDEFINE")
      set(keyword "UNDEFINE")
    elseif(arg STREQUAL "MACROS")
      set(keyword "MACROS")
      list(APPEND FPP_ARGS "-macros")
    elseif(arg STREQUAL "NOMACROS")
      set(keyword "NOMACROS")
      list(APPEND FPP_ARGS "-nomacros")
    elseif(arg STREQUAL "BLANKS")
      set(keyword "BLANKS")
      list(APPEND FPP_ARGS "-blanks")
    elseif(arg STREQUAL "NOBLANKS")
      set(keyword "NOBLANKS")
      list(APPEND FPP_ARGS "-noblanks")
    elseif(arg STREQUAL "SUFFIX")
      message(STATUS "INVOCATION: FPreProcess(${ARGV})")
      message(FATAL_ERROR "FPreProcessor -suffix option not supported")
    else()
      if(keyword STREQUAL "DEFINE")
        list(APPEND FPP_ARGS "-D${arg}")
      elseif(keyword STREQUAL "UNDEFINE")
        list(APPEND FPP_ARGS "-U${arg}")
      else()
        message(STATUS "INVOCATION: FPreProcess(${ARGV})")
        message(FATAL_ERROR "unknown FPreProcessor keyword ${arg}")
      endif()
    endif()
  endforeach()
  
  add_custom_command(
    OUTPUT ${outfile}
    COMMAND ${PERL_EXECUTABLE} ${FPP_PATH} ${FPP_ARGS} -o ${outfile} -- ${infile}
    DEPENDS ${infile}
    WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
  )
endfunction(FPreProcess)
