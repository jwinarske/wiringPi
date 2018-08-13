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

project(wiringPiD LANGUAGES C)

set(CMAKE_THREAD_PREFER_PTHREAD TRUE)
find_package(Threads REQUIRED)

find_library(WIRINGPI_LIB wiringPi HINTS "${CMAKE_INSTALL_PREFIX}/lib" 
    CMAKE_FIND_ROOT_PATH_BOTH)

set(SRC_FILES
  wiringpid.c
  network.c
  runRemote.c
  daemonise.c
)

include_directories (.)
include_directories (./../wiringPi)

if ("${CMAKE_C_COMPILER_ID}" STREQUAL "GNU")
  add_definitions(-D_GNU_SOURCE)
endif()

set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -Wall -Wextra -Winline -pipe")

add_executable(wiringpid ${SRC_FILES})
target_link_libraries(wiringpid ${WIRINGPI_LIB} ${CMAKE_THREAD_LIBS_INIT} -lrt -lm -lcrypt)
install(TARGETS ${name} DESTINATION ${CMAKE_INSTALL_PREFIX}/bin)

