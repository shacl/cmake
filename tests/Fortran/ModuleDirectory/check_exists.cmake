if(NOT EXISTS ${module_file})
  message(SEND_ERROR "${module_file} does not exist")
endif()
