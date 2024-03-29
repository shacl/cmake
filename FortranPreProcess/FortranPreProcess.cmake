find_package(Perl REQUIRED)

include_guard(GLOBAL)

set(
  FPP_PATH "${CMAKE_CURRENT_LIST_DIR}/fpp.pl"
  CACHE STRING "path to Fortran preprocessor script")

function(FortranPreProcess infile outfile)
  set(working_directory "${CMAKE_CURRENT_SOURCE_DIR}")
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
    elseif(arg STREQUAL "WORKING_DIRECTORY")
      set(keyword "WORKING_DIRECTORY")
    elseif(arg STREQUAL "INCLUDE")
      set(keyword "INCLUDE")
    elseif(arg STREQUAL "SUFFIX")
      message(STATUS "INVOCATION: FortranPreProcess(${ARGV})")
      message(FATAL_ERROR "FortranPreProcessor -suffix option not supported")
    else()
      if(keyword STREQUAL "DEFINE")
        set(-D)
        if(arg MATCHES "[$]<.*>$")
          list(APPEND FPP_ARGS "$<$<BOOL:${arg}>:-D$<JOIN:${arg},\t-D>>")
        else()
          list(APPEND FPP_ARGS "-D${arg}")
        endif()
      elseif(keyword STREQUAL "UNDEFINE")
        if(arg MATCHES "[$]<.*>$")
          list(APPEND FPP_ARGS "$<$<BOOL:${arg}>:-U$<JOIN:${arg},\t-U>>")
        else()
          list(APPEND FPP_ARGS "-U${arg}")
        endif()
      elseif(keyword STREQUAL "WORKING_DIRECTORY")
        set(working_directory ${arg})
      elseif(keyword STREQUAL "INCLUDE")
        set(-I)
        if(arg MATCHES "[$]<.*>$")
          list(APPEND FPP_ARGS "$<$<BOOL:${arg}>:-I$<JOIN:${arg},\t-I>>")
        else()
          list(APPEND FPP_ARGS "-I${arg}")
        endif()
      else()
        message(STATUS "INVOCATION: FortranPreProcess(${ARGV})")
        message(FATAL_ERROR "unknown FortranPreProcess keyword ${arg}")
      endif()
    endif()
  endforeach()

  add_custom_command(
    OUTPUT "${outfile}"
    COMMAND "${PERL_EXECUTABLE}" "${FPP_PATH}" ${FPP_ARGS} -o "${outfile}" -- "${infile}"
    DEPENDS "${infile}"
    WORKING_DIRECTORY "${working_directory}")

endfunction(FortranPreProcess)
