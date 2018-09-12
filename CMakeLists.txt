# Distributed under the OSI-approved BSD 3-Clause License.  See accompanying
# file LICENSE

cmake_minimum_required (VERSION 2.8)
set (CMAKE_MODULE_PATH "${CMAKE_MODULE_PATH};${CMAKE_SOURCE_DIR}/cmake")

project (Hello Haskell)
add_executable (Hello Main.hs)

