cmake_minimum_required(VERSION 3.12.1)
include_guard(GLOBAL)

set(CXX_exceptions_static_linkable_root_dir 
  ${CMAKE_CURRENT_LIST_DIR}/ExceptionsStaticLinkableWith
  CACHE INTERNAL ""
)

function(CXX_exceptions_static_linkable_with)
  foreach(lang IN LISTS ARGN)
    if( DEFINED CXX_exceptions_static_linkable_with_${lang} )
      continue()
    endif()

    set(test_project_source_dir
      ${CXX_exceptions_static_linkable_root_dir}/CXX_exceptions_${lang}_static_linkable
    )

    if( NOT EXISTS ${test_project_source_dir} )
      message(FATAL_ERROR
        "A test project for linking CXX static library code with exceptions using ${lang} does not exists at ${test_project_source_dir}")
    endif()

    try_compile(compatible
      ${CMAKE_CURRENT_BINARY_DIR}/CXX_exceptions_${lang}_static_linkable
      ${test_project_source_dir}
      CXX_exceptions_${lang}_static_linkable
      abi)

    if( compatible )
      execute_process(COMMAND ${CMAKE_CURRENT_BINARY_DIR}/CXX_exceptions_${lang}_static_linkable/abi
        RESULT_VARIABLE compatible
        OUTPUT_QUIET
        ERROR_QUIET
      )
    endif()

    if( NOT compatible EQUAL 0 )
      set(CXX_exceptions_static_linkable_with_${lang} FALSE 
        CACHE INTERNAL "")
    else()
      set(CXX_exceptions_static_linkable_with_${lang} TRUE
        CACHE INTERNAL "")
    endif()
  endforeach()
endfunction() 
