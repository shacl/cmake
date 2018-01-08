# Here we're using the existance of global properties to act as something
# analoguous to C/C++ header guards to ensure the contents of this file are not
# redundantly defined.

get_property(
  FortranPreProcess.target_sources.cmake
  GLOBAL PROPERTY FortranPreProcess.target_sources.cmake SET)

if(NOT FortranPreProcess.target_sources.cmake)
  include(FortranPreProcess/FortranPreProcess)
  include(FortranPreProcess/filename)
  include(GeneratedSources)

  backup(target_sources)

  function(target_sources target tag linkage)
    if(NOT ${tag} STREQUAL "PREPROCESS")
      previous_target_sources(${ARGV})
      return()
    endif()

    get_target_property(definitions ${target} COMPILE_DEFINITIONS)
    string(REPLACE ";" " " definitions "${definitions}")

    foreach(arg IN LISTS ARGN)
      if(arg STREQUAL "PUBLIC"
          OR arg STREQUAL "PRIVATE"
          OR arg STREQUAL "INTERFACE")
        set(linkage ${arg})
      else()
        if(NOT "${arg}" MATCHES ".*\.F([0-9][0-9])?$")
          previous_target_source(${target} PREPROCESS ${linkage} "${arg}")
          return()
        endif()

        file(RELATIVE_PATH path ${CMAKE_CURRENT_SOURCE_DIR} "${arg}")
        get_filename_component(directory "${path}" DIRECTORY)
        file(MAKE_DIRECTORY "${CMAKE_CURRENT_BINARY_DIR}/${directory}")

        FortranPreProcess_filename("${path}" preprocessed_path)
        FortranPreProcess(
          "${CMAKE_CURRENT_SOURCE_DIR}/${path}"
          "${CMAKE_CURRENT_BINARY_DIR}/${preprocessed_path}"
          DEFINE ${definitions})

        previous_target_sources(${target} GENERATED ${linkage}
          "${CMAKE_CURRENT_BINARY_DIR}/${preprocessed_path}")
      endif()
    endforeach()
  endfunction()

  set_property(
    GLOBAL PROPERTY FortranPreprocess.target_sources.cmake
    "This is a header guard")
endif()
