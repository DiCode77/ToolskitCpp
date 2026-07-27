cmake_minimum_required(VERSION 3.25)
project(ToolsKitCpp LANGUAGES CXX OBJCXX)

set(SRC_SWITCH "${CMAKE_CURRENT_SOURCE_DIR}/switch/src")
set(PROJ_LIB_NAME_SWITCH "${PROJECT_NAME}")

file(GLOB_RECURSE SRC_FILES_LIB_SWITCH "${SRC_SWITCH}/*.hpp" "${SRC_SWITCH}/*.h" "${SRC_SWITCH}/*.mm")
file(GLOB_RECURSE PUBLIC_HEADERS "${SRC_SWITCH}/*.hpp")

find_library(APPKIT_FRAMEWORK AppKit REQUIRED)
find_library(MAPKIT_FRAMEWORK MapKit REQUIRED)
find_library(CORE_LOCATION_FRAMEWORK CoreLocation REQUIRED)
find_library(FOUNDATION_FRAMEWORK Foundation REQUIRED)

add_library(${PROJ_LIB_NAME_SWITCH} SHARED ${SRC_FILES_LIB_SWITCH})

target_include_directories(${PROJ_LIB_NAME_SWITCH} PUBLIC ${SRC_SWITCH})

target_link_libraries(${PROJ_LIB_NAME_SWITCH} PUBLIC 
                                            ${APPKIT_FRAMEWORK} 
                                            ${MAPKIT_FRAMEWORK} 
                                            ${CORE_LOCATION_FRAMEWORK} 
                                            ${FOUNDATION_FRAMEWORK})

set_target_properties(${PROJ_LIB_NAME_SWITCH} PROPERTIES 
                                                CXX_STANDARD 23 
                                                CXX_STANDARD_REQUIRED ON 
                                                FRAMEWORK TRUE 
                                                FRAMEWORK_VERSION A 
                                                PUBLIC_HEADER ${PUBLIC_HEADERS})

source_group("switch\\src" FILES ${SRC_FILES_LIB_SWITCH})