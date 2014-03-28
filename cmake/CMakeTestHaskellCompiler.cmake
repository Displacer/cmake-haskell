
#=============================================================================
# Copyright 2003-2009 Kitware, Inc.
#
# Distributed under the OSI-approved BSD License (the "License");
# see accompanying file Copyright.txt for details.
#
# This software is distributed WITHOUT ANY WARRANTY; without even the
# implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
# See the License for more information.
#=============================================================================
# (To distribute this file outside of CMake, substitute the full
#  License text for the above reference.)

INCLUDE(CMakeTestCompilerCommon)

# This file is used by EnableLanguage in cmGlobalGenerator to
# determine that that selected Haskell compiler can actually compile
# and link the most basic of programs.   If not, a fatal error
# is set and cmake stops processing commands and will not generate
# any makefiles or projects.
IF(NOT CMAKE_Haskell_COMPILER_WORKS)
  PrintTestCompilerStatus("Haskell" "")
  FILE(WRITE ${CMAKE_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/CMakeTmp/testHaskellCompiler.hs 
    "main = return ()\n")
  TRY_COMPILE(CMAKE_Haskell_COMPILER_WORKS ${CMAKE_BINARY_DIR} 
    ${CMAKE_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/CMakeTmp/testHaskellCompiler.hs
    OUTPUT_VARIABLE OUTPUT)
  SET(Haskell_TEST_WAS_RUN 1)
ENDIF(NOT CMAKE_Haskell_COMPILER_WORKS)

IF(NOT CMAKE_Haskell_COMPILER_WORKS)
  PrintTestCompilerStatus("Haskell" " -- broken")
  FILE(APPEND ${CMAKE_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/CMakeError.log
    "Determining if the Haskell compiler works failed with "
    "the following output:\n${OUTPUT}\n\n")
  MESSAGE(FATAL_ERROR "The Haskell compiler \"${CMAKE_Haskell_COMPILER}\" "
    "is not able to compile a simple test program.\nIt fails "
    "with the following output:\n ${OUTPUT}\n\n"
    "CMake will not be able to correctly generate this project.")
ELSE(NOT CMAKE_Haskell_COMPILER_WORKS)
  IF(Haskell_TEST_WAS_RUN)
    PrintTestCompilerStatus("Haskell" " -- works")
    FILE(APPEND ${CMAKE_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/CMakeOutput.log
      "Determining if the Haskell compiler works passed with "
      "the following output:\n${OUTPUT}\n\n")
  ENDIF(Haskell_TEST_WAS_RUN)
  SET(CMAKE_Haskell_COMPILER_WORKS 1 CACHE INTERNAL "")
ENDIF(NOT CMAKE_Haskell_COMPILER_WORKS)
