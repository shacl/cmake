if(CMAKE_SYSTEM_ID STREQUAL "Windows") 
  set(int_size.8BYTE_FLAG "/integer-size:64")
else()
  set(int_size.8BYTE_FLAG "-i8")
endif()

if( INT_SIZE STREQUAL "8" ) 
  set(int_size.flag "${int_size.8BYTE_FLAG}")
else()
  message(FATAL_ERROR "INT_SIZE: Option ${INT_SIZE} Not recognized" )
endif()

unset(int_size.8BYTE_FLAG)
