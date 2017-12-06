if(NOT DEFINED GIT_FOUND)
  find_package(git)
  if(NOT ${GIT_FOUND})
    message(FATAL "git installation not found")
  endif()
endif()

function(populate_submodule_list)
  list(APPEND submodules)

  if(EXISTS "${PROJECT_SOURCE_DIR}/.gitmodules")
    execute_process(
      COMMAND "${GIT_EXECUTABLE} config --file .gitmodules --name-only --get-regexp path"
      WORKING_DIRECTORY "${PROJECT_SOURCE_DIR}"
      OUTPUT_VARIABLE submodule_listing)

    set(submodule_listing ${submodule_listing})

    foreach(entry IN LIST ${CMAKE_PROJECT_NAME}_submodule_listing)
      if(EXISTS ${entry})
        get_filename_component(name ${entry} NAME)
        list(APPEND ${CMAKE_PROJECT_NAME}_submodules ${name})
        set(${name}_path ${entry} CACHE PATH "")
      endif()
    endforeach()
  endif()

  set(${CMAKE_PROJECT_NAME}_submodules
      ${${CMAKE_PROJECT_NAME}_submodules} CACHE INTERNAL
      "CMake Lists of submodules")
endfunction()

function(clone_submodule submodule)
  execute_process(
      COMMAND "${GIT_EXECUTABLE} submodule update --init -- ${${submodule}_path}"
      WORKING_DIRECTORY "${PROJECT_SOURCE_DIR}")
endfunction()
