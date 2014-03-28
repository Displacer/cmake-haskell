cmake_minimum_required(VERSION 2.8)

set(CMAKE_MODULE_DIRECTORY "${CMAKE_SOURCE_DIR}/cmake")
set(CMAKE_MODULE_PATH "${CMAKE_MODULE_PATH};${CMAKE_MODULE_DIRECTORY}")

project(Hello Haskell)

add_executable(Hello Main.hs)
