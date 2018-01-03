# first arg is actually variable name
# 2nd to last argurment is same var which is a property not necessarily a variable
# This acts like a header guard (#ifndef BLAH #def BLAH #endif ) 

get_property(
  real_size.cmake
  GLOBAL PROPERTY real_size.cmake SET)
 
# if not set, then set it as an option
if(NOT real_size.cmake)
  set(GLOBAL PROPERTY real_size.cmake)
  # Default setting is not to mess with default size of reals
  set(REAL_SIZE "8" CACHE STRING "Force the default fortran real size ( Off=Default compiler setting )" )

  set_property(CACHE REAL_SIZE PROPERTY STRINGS "4" "8" "Off")

  if(REAL_SIZE) 
     # if it is set then use the value of REAL_SIZE to determine FLAG setting.
     # There will be a COMPILER_ID file underneath the real_size directory
     # for each compiler vendor.  Each file will handle platform specific
     # settings of the flag.
     include(real_size/${CMAKE_Fortran_COMPILER_ID})
     add_library(real_size INTERFACE)
     target_compile_options(real_size INTERFACE "${real_size.flag}")

     if(REAL_SIZE STREQUAL "8") 
	     target_compile_definitions(int_size INTERFACE "F90_REAL_8BYTE")
     elseif(REAL_SIZE STREQUAL "4") 
	     target_compile_definitions(int_size INTERFACE "F90_REAL_4BYTE")
     endif()

   endif()

endif()  

# cleanup all variables that were set with this option.
unset(real_size.cmake)
unset(real_size.flag)
