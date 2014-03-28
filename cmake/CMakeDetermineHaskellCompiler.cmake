
#=============================================================================
# Copyright 2004-2009 Kitware, Inc.
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

# determine the compiler to use for Haskell programs
# NOTE, a generator may set CMAKE_Haskell_COMPILER before
# loading this file to force a compiler. 
# use environment variable CXX first if defined by user, next use
# the cmake variable CMAKE_GENERATOR_CXX which can be defined by a generator
# as a default compiler
#
# Sets the following variables:
#   CMAKE_HASKELL_COMPILER
#   CMAKE_COMPILER_IS_GHC

IF(NOT CMAKE_Haskell_COMPILER)
  # prefer the environment variable HASKELL_COMPILER
  IF($ENV{HASKELL_COMPILER} MATCHES ".+")
    GET_FILENAME_COMPONENT(CMAKE_Haskell_COMPILER_INIT $ENV{HASKELL_COMPILER} PROGRAM PROGRAM_ARGS CMAKE_Haskell_FLAGS_ENV_INIT)
    IF(CMAKE_Haskell_FLAGS_ENV_INIT)
      SET(CMAKE_Haskell_COMPILER_ARG1 "${CMAKE_Haskell_FLAGS_ENV_INIT}" CACHE STRING "First argument to Haskell compiler")
    ENDIF(CMAKE_Haskell_FLAGS_ENV_INIT)
    IF(NOT EXISTS ${CMAKE_Haskell_COMPILER_INIT})
      MESSAGE(FATAL_ERROR "Could not find compiler set in environment variable Haskell:\n$ENV{HASKELL_COMPILER}.\n${CMAKE_Haskell_COMPILER_INIT}")
    ENDIF(NOT EXISTS ${CMAKE_Haskell_COMPILER_INIT})
  ENDIF($ENV{HASKELL_COMPILER} MATCHES ".+")

  # next try prefer the compiler specified by the generator
  IF(CMAKE_GENERATOR_FC)
    IF(NOT CMAKE_Haskell_COMPILER_INIT)
      SET(CMAKE_Haskell_COMPILER_INIT ${CMAKE_GENERATOR_FC})
    ENDIF(NOT CMAKE_Haskell_COMPILER_INIT)
  ENDIF(CMAKE_GENERATOR_FC)

  # finally list compilers to try
  IF(CMAKE_Haskell_COMPILER_INIT)
    SET(CMAKE_Haskell_COMPILER_LIST ${CMAKE_Haskell_COMPILER_INIT})
  ELSE(CMAKE_Haskell_COMPILER_INIT)
    SET(CMAKE_Haskell_COMPILER_LIST ghc)
  ENDIF(CMAKE_Haskell_COMPILER_INIT)

  # Find the compiler.
  IF (_CMAKE_USER_Haskell_COMPILER_PATH)
    FIND_PROGRAM(CMAKE_CXX_COMPILER NAMES ${CMAKE_Haskell_COMPILER_LIST} PATHS ${_CMAKE_USER_Haskell_COMPILER_PATH} DOC "Haskell compiler" NO_DEFAULT_PATH)
  ENDIF (_CMAKE_USER_Haskell_COMPILER_PATH)
  FIND_PROGRAM(CMAKE_Haskell_COMPILER NAMES ${CMAKE_Haskell_COMPILER_LIST} DOC "Haskell compiler")

  IF(CMAKE_Haskell_COMPILER_INIT AND NOT CMAKE_Haskell_COMPILER)
    SET(CMAKE_Haskell_COMPILER "${CMAKE_Haskell_COMPILER_INIT}" CACHE FILEPATH "Haskell compiler" FORCE)
  ENDIF(CMAKE_Haskell_COMPILER_INIT AND NOT CMAKE_Haskell_COMPILER)
ELSE(NOT CMAKE_Haskell_COMPILER)

# we only get here if CMAKE_Haskell_COMPILER was specified using -D or a pre-made CMakeCache.txt
# (e.g. via ctest) or set in CMAKE_TOOLCHAIN_FILE
#
# if CMAKE_Haskell_COMPILER is a list of length 2, use the first item as
# CMAKE_Haskell_COMPILER and the 2nd one as CMAKE_Haskell_COMPILER_ARG1

  LIST(LENGTH CMAKE_Haskell_COMPILER _CMAKE_Haskell_COMPILER_LIST_LENGTH)
  IF("${_CMAKE_Haskell_COMPILER_LIST_LENGTH}" EQUAL 2)
    LIST(GET CMAKE_Haskell_COMPILER 1 CMAKE_Haskell_COMPILER_ARG1)
    LIST(GET CMAKE_Haskell_COMPILER 0 CMAKE_Haskell_COMPILER)
  ENDIF("${_CMAKE_Haskell_COMPILER_LIST_LENGTH}" EQUAL 2)

# if a compiler was specified by the user but without path,
# now try to find it with the full path
# if it is found, force it into the cache,
# if not, don't overwrite the setting (which was given by the user) with "NOTFOUND"
  GET_FILENAME_COMPONENT(_CMAKE_USER_Haskell_COMPILER_PATH "${CMAKE_Haskell_COMPILER}" PATH)
  IF(NOT _CMAKE_USER_Haskell_COMPILER_PATH)
    FIND_PROGRAM(CMAKE_Haskell_COMPILER_WITH_PATH NAMES ${CMAKE_Haskell_COMPILER})
    MARK_AS_ADVANCED(CMAKE_Haskell_COMPILER_WITH_PATH)
    IF(CMAKE_Haskell_COMPILER_WITH_PATH)
      SET(CMAKE_Haskell_COMPILER ${CMAKE_Haskell_COMPILER_WITH_PATH} CACHE STRING "Haskell compiler" FORCE)
    ENDIF(CMAKE_Haskell_COMPILER_WITH_PATH)
  ENDIF(NOT _CMAKE_USER_Haskell_COMPILER_PATH)
ENDIF(NOT CMAKE_Haskell_COMPILER)
MARK_AS_ADVANCED(CMAKE_Haskell_COMPILER)

INCLUDE(CMakeFindBinUtils)

# configure variables set in this file for fast reload later on
CONFIGURE_FILE(${CMAKE_CURRENT_LIST_DIR}/CMakeHaskellCompiler.cmake.in
  ${CMAKE_PLATFORM_INFO_DIR}/CMakeHaskellCompiler.cmake
  @ONLY IMMEDIATE # IMMEDIATE must be here for compatibility mode <= 2.0
  )

SET(CMAKE_Haskell_COMPILER_ENV_VAR "HASKELL_COMPILER")