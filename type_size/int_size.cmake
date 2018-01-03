# first arg is actually variable name
# 2nd to last argurment is same var which is a property not necessarily a variable
# This acts like a header guard (#ifndef BLAH #def BLAH #endif ) 

get_property(
  int_size.cmake
  GLOBAL PROPERTY int_size.cmake SET)
 
# if not set, then set it as an option
if(NOT int_size.cmake)
  set(GLOBAL PROPERTY int_size.cmake)
  # Default setting is not to mess with default size of integers
  set(INT_SIZE "8" CACHE STRING "Force the default fortran integer size ( Off=Default compiler setting )" )

  set_property(CACHE INT_SIZE PROPERTY STRINGS "8" "Off")

  if(INT_SIZE) 
     # if it is set then use the value of INT_SIZE to determine FLAG setting.
     # There will be a COMPILER_ID file underneath the int_size directory
     # for each compiler vendor.  Each file will handle platform specific
     # settings of the flag.
     include(int_size/${CMAKE_Fortran_COMPILER_ID})
     add_library(int_size INTERFACE)
     target_compile_options(int_size INTERFACE "${int_size.flag}")
  endif()

endif()  

# cleanup all variables that were set with this option.
unset(int_size.cmake)
unset(int_size.flag)
