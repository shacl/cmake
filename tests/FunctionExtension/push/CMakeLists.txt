cmake_minimum_required( VERSION 2.8 )
project( push_test )
list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_LIST_DIR}/../../..")

include(FunctionExtension)

# - - - - - - - - - - - - -
# setting testVar
# - - - - - - - - - - - - -
set( testVar "original" )

if( NOT testVar STREQUAL "original" )
  message( FATAL_ERROR "testVar should be equal to original" )
endif()

if( DEFINED _testVar )
  message( FATAL_ERROR "_testVar should not be defined" )
endif()

if( DEFINED __testVar )
  message( FATAL_ERROR "__testVar should not be defined" )  
endif()

# - - - - - - - - - - - - -
# calling push
# - - - - - - - - - - - - -
push( testVar )

if( NOT testVar STREQUAL "original" )
  message( FATAL_ERROR "testVar should be equal to original" )
endif()

if( NOT _testVar STREQUAL "original" )
  message( FATAL_ERROR "_testVar should be equal to original" )  
endif()

if( DEFINED __testVar )
  message( FATAL_ERROR "__testVar should not be defined" )  
endif()

# - - - - - - - - - - - - -
# updating testVar
# - - - - - - - - - - - - -
set( testVar "revised" )

if( NOT testVar STREQUAL "revised" )
  message( FATAL_ERROR "testVar should be equal to original" )
endif()

if( NOT _testVar STREQUAL "original" )
  message( FATAL_ERROR "_testVar should be equal to original" )  
endif()

if( DEFINED __testVar )
  message( FATAL_ERROR "__testVar should not be defined" )  
endif()

# - - - - - - - - - - - - -
# calling push again
# - - - - - - - - - - - - -
push( testVar )

if( NOT testVar STREQUAL "revised" )
  message( FATAL_ERROR "testVar should be equal to original" )
endif()

if( NOT _testVar STREQUAL "revised" )
  message( FATAL_ERROR "_testVar should be equal to revised" )  
endif()

if( NOT __testVar STREQUAL "original" )
  message( FATAL_ERROR "__testVar should be equal to original" )  
endif()
