cmake_minimum_required(VERSION 3.2.0)
project(FortranCompileOptions LANGUAGES Fortran VERSION 1.0.0)

add_subdirectory(Backtrace)
add_subdirectory(FreeForm)
add_subdirectory(IntelDiagDisable)
add_subdirectory(IntelWarn)
add_subdirectory(Standard2008)
add_subdirectory(TempArrayHeapAlloc)
