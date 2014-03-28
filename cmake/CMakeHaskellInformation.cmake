
#=============================================================================
# Copyright 2004-2011 Kitware, Inc.
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

# This file sets the basic flags for the Haskell language in CMake.


SET(CMAKE_Haskell_OUTPUT_EXTENSION .o)

INCLUDE(CMakeCommonLanguageInclude)

# now define the following rules:
# CMAKE_Haskell_CREATE_SHARED_LIBRARY
# CMAKE_Haskell_CREATE_SHARED_MODULE
# CMAKE_Haskell_COMPILE_OBJECT
# CMAKE_Haskell_LINK_EXECUTABLE

# variables supplied by the generator at use time
# <TARGET>
# <TARGET_BASE> the target without the suffix
# <OBJECTS>
# <OBJECT>
# <LINK_LIBRARIES>
# <FLAGS>
# <LINK_FLAGS>

# Haskell compiler information
# <CMAKE_Haskell_COMPILER>  
# <CMAKE_SHARED_LIBRARY_CREATE_Haskell_FLAGS>
# <CMAKE_Haskell_SHARED_MODULE_CREATE_FLAGS>
# <CMAKE_Haskell_LINK_FLAGS>

# Static library tools
# <CMAKE_AR> 
# <CMAKE_RANLIB>


# create a shared Haskell library
IF(NOT CMAKE_Haskell_CREATE_SHARED_LIBRARY)
  SET(CMAKE_Haskell_CREATE_SHARED_LIBRARY
      "<CMAKE_Haskell_COMPILER> <CMAKE_SHARED_LIBRARY_Haskell_FLAGS> <LANGUAGE_COMPILE_FLAGS> <LINK_FLAGS> <CMAKE_SHARED_LIBRARY_CREATE_Haskell_FLAGS> <CMAKE_SHARED_LIBRARY_SONAME_Haskell_FLAG><TARGET_SONAME> -o <TARGET> <OBJECTS> <LINK_LIBRARIES>")
ENDIF(NOT CMAKE_Haskell_CREATE_SHARED_LIBRARY)

# create a Haskell shared module copy the shared library rule by default
IF(NOT CMAKE_Haskell_CREATE_SHARED_MODULE)
  SET(CMAKE_Haskell_CREATE_SHARED_MODULE ${CMAKE_Haskell_CREATE_SHARED_LIBRARY})
ENDIF(NOT CMAKE_Haskell_CREATE_SHARED_MODULE)


# Create a static archive incrementally for large object file counts.
# If CMAKE_Haskell_CREATE_STATIC_LIBRARY is set it will override these.
IF(NOT DEFINED CMAKE_Haskell_ARCHIVE_CREATE)
  SET(CMAKE_Haskell_ARCHIVE_CREATE "<CMAKE_AR> cr <TARGET> <LINK_FLAGS> <OBJECTS>")
ENDIF()
IF(NOT DEFINED CMAKE_Haskell_ARCHIVE_APPEND)
  SET(CMAKE_Haskell_ARCHIVE_APPEND "<CMAKE_AR> r  <TARGET> <LINK_FLAGS> <OBJECTS>")
ENDIF()
IF(NOT DEFINED CMAKE_Haskell_ARCHIVE_FINISH)
  SET(CMAKE_Haskell_ARCHIVE_FINISH "<CMAKE_RANLIB> <TARGET>")
ENDIF()

# compile a Haskell file into an object file
IF(NOT CMAKE_Haskell_COMPILE_OBJECT)
  SET(CMAKE_Haskell_COMPILE_OBJECT
    "<CMAKE_Haskell_COMPILER>  <DEFINES> <FLAGS> -hidir <CMAKE_CURRENT_BINARY_DIR> -o <OBJECT> -c <SOURCE>")
ENDIF(NOT CMAKE_Haskell_COMPILE_OBJECT)

IF(NOT CMAKE_Haskell_LINK_EXECUTABLE)
  SET(CMAKE_Haskell_LINK_EXECUTABLE
    "<CMAKE_Haskell_COMPILER>  <FLAGS> <CMAKE_Haskell_LINK_FLAGS> <LINK_FLAGS> <OBJECTS>  -o <TARGET> <LINK_LIBRARIES>")
ENDIF(NOT CMAKE_Haskell_LINK_EXECUTABLE)

MARK_AS_ADVANCED(
CMAKE_BUILD_TOOL
CMAKE_VERBOSE_MAKEFILE 
CMAKE_Haskell_FLAGS
CMAKE_Haskell_FLAGS_RELEASE
CMAKE_Haskell_FLAGS_RELWITHDEBINFO
CMAKE_Haskell_FLAGS_MINSIZEREL
CMAKE_Haskell_FLAGS_DEBUG)

SET(CMAKE_Haskell_INFORMATION_LOADED 1)

