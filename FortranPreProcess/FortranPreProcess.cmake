# Here we're using the existance of global properties to act as something
# analoguous to C/C++ header guards to ensure the contents of this file are not
# redundantly defined.

get_property(
  FortranPreprocess.FortranPreProcess.cmake GLOBAL PROPERTY
  FortranPreprocess.FortranPreProcess.cmake SET)

if(NOT FortranPreprocess.FortranPreProcess.cmake)
  find_package(Perl REQUIRED)

  set(
    FPP_PATH "${CMAKE_CURRENT_LIST_DIR}/fpp.pl"
    CACHE string "path to Fortran preprocessor script")

  function(FortranPreProcess infile outfile)
    set(working_directory ${CMAKE_CURRENT_SOURCE_DIR})
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
      elseif(arg STREQUAL "SUFFIX")
        message(STATUS "INVOCATION: FortranPreProcess(${ARGV})")
        message(FATAL_ERROR "FortranPreProcessor -suffix option not supported")
      else()
        if(keyword STREQUAL "DEFINE")
          list(APPEND FPP_ARGS "-D${arg}")
        elseif(keyword STREQUAL "UNDEFINE")
          list(APPEND FPP_ARGS "-U${arg}")
        elseif(keyword STREQUAL "WORKING_DIRECTORY")
          set(working_directory ${arg})
        else()
          message(STATUS "INVOCATION: FortranPreProcess(${ARGV})")
          message(FATAL_ERROR "unknown FortranPreProcess keyword ${arg}")
        endif()
      endif()
    endforeach()

    add_custom_command(
      OUTPUT ${outfile}
      COMMAND ${PERL_EXECUTABLE} ${FPP_PATH} ${FPP_ARGS} -o ${outfile} -- ${infile}
      DEPENDS ${infile}
      WORKING_DIRECTORY ${working_directory})

  endfunction(FortranPreProcess)

  set_property(
    GLOBAL PROPERTY FortranPreprocess.FortranPreProcess.cmake
    "This is a header guard")
endif()
