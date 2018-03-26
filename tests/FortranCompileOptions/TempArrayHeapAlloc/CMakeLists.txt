cmake_minimum_required( VERSION 3.2.0 )
project( test_TempArrayHeapAlloc LANGUAGES Fortran )
list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_LIST_DIR}/../../..")

include(FortranCompileOptions/TempArrayHeapAlloc)

MakeTempArrayHeapAllocTarget(1024)
add_executable(use_temp_array_heap_alloc use_temp_array_heap_alloc.f90)

target_link_libraries(use_temp_array_heap_alloc PRIVATE Fortran::TempArrayHeapAlloc_1024)
