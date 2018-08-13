#
# CMakeLists.txt:
#	wiringPi - A "wiring" library for the Raspberry Pi
#	https://projects.drogon.net/wiring-pi
#
#	Copyright (c) 2018 Joel Winarske
#################################################################################
# This file is part of wiringPi:
#	A "wiring" library for the Raspberry Pi
#
#    wiringPi is free software: you can redistribute it and/or modify
#    it under the terms of the GNU Lesser General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    wiringPi is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU Lesser General Public License for more details.
#
#    You should have received a copy of the GNU Lesser General Public License
#    along with wiringPi.  If not, see <http://www.gnu.org/licenses/>.
#################################################################################
cmake_minimum_required(VERSION 3.0)

project(wiringPi LANGUAGES C)

# Version
file(READ "${CMAKE_SOURCE_DIR}/version.h" WIRINGPI_VERSION)
string(REGEX MATCH "define VERSION_MAJOR ([0-9]*)" _ ${WIRINGPI_VERSION})
set(WIRINGPI_VERSION_MAJOR ${CMAKE_MATCH_1})
string(REGEX MATCH "define VERSION_MINOR ([0-9]*)" _ ${WIRINGPI_VERSION})
set(WIRINGPI_VERSION_MINOR ${CMAKE_MATCH_1})
message("Building WiringPi Version: ${WIRINGPI_VERSION_MAJOR}.${WIRINGPI_VERSION_MINOR}")


include (ExternalProject)

set(CMAKE_INSTALL_PREFIX ${CMAKE_BINARY_DIR}/out)

ExternalProject_Add(wiringPi
      SOURCE_DIR ${CMAKE_SOURCE_DIR}/wiringPi
      DOWNLOAD_COMMAND ""
      BUILD_IN_SOURCE 0
      CMAKE_ARGS ${EXTRA_ARGS}
        -DCMAKE_PREFIX_PATH=${CMAKE_PREFIX_PATH}
        -DCMAKE_INSTALL_PREFIX=${CMAKE_INSTALL_PREFIX}
        -DCMAKE_TOOLCHAIN_FILE=${CMAKE_TOOLCHAIN_FILE}
        -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE}
)

ExternalProject_Add(devLib
      SOURCE_DIR ${CMAKE_SOURCE_DIR}/devLib
      DOWNLOAD_COMMAND ""
      BUILD_IN_SOURCE 0
      CMAKE_ARGS ${EXTRA_ARGS}
        -DCMAKE_PREFIX_PATH=${CMAKE_PREFIX_PATH}
        -DCMAKE_INSTALL_PREFIX=${CMAKE_INSTALL_PREFIX}
        -DCMAKE_TOOLCHAIN_FILE=${CMAKE_TOOLCHAIN_FILE}
        -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE}
)

macro(proj name path)
  ExternalProject_Add(${name}
        SOURCE_DIR ${CMAKE_SOURCE_DIR}/${path}
        DOWNLOAD_COMMAND ""
        BUILD_IN_SOURCE 0
        CMAKE_ARGS ${EXTRA_ARGS}
          -DCMAKE_PREFIX_PATH=${CMAKE_PREFIX_PATH}
          -DCMAKE_INSTALL_PREFIX=${CMAKE_INSTALL_PREFIX}
          -DCMAKE_TOOLCHAIN_FILE=${CMAKE_TOOLCHAIN_FILE}
          -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE}
  )
  add_dependencies(${name} wiringPi devLib)
endmacro(proj)


proj(gpio gpio)
proj(wiringPiD wiringPiD)
proj(examples examples)
proj(Gertboard examples/Gertboard)
proj(PiFace examples/PiFace)
proj(q2w examples/q2w)
proj(PiGlow examples/PiGlow)
proj(scrollPhat examples/scrollPhat)


add_custom_target(uninstall "${CMAKE_COMMAND}" -P "${CMAKE_SOURCE_DIR}/cmake/make_uninstall.cmake")

