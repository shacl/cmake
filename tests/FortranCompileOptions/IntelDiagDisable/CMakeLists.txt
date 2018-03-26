cmake_minimum_required( VERSION 3.2.0 )
project( test_IntelDiagDissable LANGUAGES Fortran )
list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_LIST_DIR}/../../..")

include(FortranCompileOptions/IntelDiagDisable)

add_executable(use_intel_diag_disable use_intel_diag_disable.f90)

target_link_libraries(use_intel_diag_disable PRIVATE Fortran::IntelDiagDisable)
