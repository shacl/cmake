cmake_minimum_required(VERSION 3.6)

set_property(GLOBAL PROPERTY USE_FOLDERS ON)

macro(generated_sources_trap target)
  function(${target}_append_generated_files variable access)
    if(${access} STREQUAL UNKNOWN_READ_ACCESS OR ${access} STREQUAL READ_ACCESS)
      get_target_property(${target}.source_directory ${target} SOURCE_DIR)

      if(${CMAKE_CURRENT_SOURCE_DIR} STREQUAL ${${target}.source_directory}
          AND TARGET ${target}.PUBLIC_generated_sources)
        foreach(linkage PUBLIC PRIVATE INTERFACE)
          get_target_property(sources
            ${target}.${linkage}_generated_sources
            INTERFACE_SOURCES)

          foreach(source IN LISTS sources)
            set_source_files_properties(${source} PROPERTIES GENERATED TRUE)
          endforeach()

          if(sources)
            target_link_libraries(${target} ${linkage}
              ${target}.${linkage}_generated_sources)
          endif()

        endforeach()
      endif()
    endif()
  endfunction()

  variable_watch(CMAKE_BACKWARDS_COMPATIBILITY ${target}_append_generated_files)
endmacro()

function(add_library target linkage)
  if(linkage STREQUAL "ALIAS")
    _add_library(${ARGV})
    return()
  endif()

  if(NOT TARGET ${target}.PUBLIC_generated_sources)
    _add_library(${target}.PUBLIC_generated_sources INTERFACE)
    _add_library(${target}.PRIVATE_generated_sources INTERFACE)
    _add_library(${target}.INTERFACE_generated_sources INTERFACE)
  endif()

  _add_library(${ARGV} "")
  generated_sources_trap(${target})
endfunction()

function(add_executable target)
  if(NOT TARGET ${target}.PUBLIC_generated_sources)
    _add_library(${target}.PUBLIC_generated_sources INTERFACE)
    _add_library(${target}.PRIVATE_generated_sources INTERFACE)
    _add_library(${target}.INTERFACE_generated_sources INTERFACE)
  endif()
  _add_executable(${ARGV} "")

  generated_sources_trap(${target})
endfunction()

function(target_sources target tag linkage)
  if(NOT tag STREQUAL "GENERATED")
    _target_sources(${ARGV})
    return()
  endif()

  foreach(entry IN LISTS ARGN)
    if(entry STREQUAL "PUBLIC"
        OR entry STREQUAL "PRIVATE"
        OR entry STREQUAL "INTERFACE")
      set(linkage ${entry})
    else()
      target_sources(${target}.${linkage}_generated_sources INTERFACE
        "${entry}")

      file(RELATIVE_PATH relative_path "${PROJECT_BINARY_DIR}" "${entry}")
      string(REPLACE "/" "." relative_path "${relative_path}")
      string(REPLACE " " "_" relative_path "${relative_path}")

      add_custom_target(
        ${target}.${linkage}_generated_sources.${relative_path}
        DEPENDS "${entry}")

      set_target_properties(
        ${target}.${linkage}_generated_sources.${relative_path}
        PROPERTIES FOLDER .generated_sources/dummy)

      add_dependencies(
        ${target}.${linkage}_generated_sources
        ${target}.${linkage}_generated_sources.${relative_path})
    endif()
  endforeach()
endfunction()
