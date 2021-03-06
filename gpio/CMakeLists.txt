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

project(gpio LANGUAGES C)

set(CMAKE_THREAD_PREFER_PTHREAD TRUE)
find_package(Threads REQUIRED)

find_library(WIRINGPI_LIB wiringPi HINTS "${CMAKE_INSTALL_PREFIX}/lib" 
    CMAKE_FIND_ROOT_PATH_BOTH)
find_library(WIRINGPIDEV_LIB wiringPiDev HINTS "${CMAKE_INSTALL_PREFIX}/lib" 
    CMAKE_FIND_ROOT_PATH_BOTH)

set(SRC_FILES 
  gpio.c readall.c
)

include_directories (.)
include_directories (./../wiringPi)
include_directories (./../devLib)


if ("${CMAKE_C_COMPILER_ID}" STREQUAL "GNU")
  add_definitions(-D_GNU_SOURCE)
endif()

set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -Wall -Wextra -Winline -pipe")

message(STATUS "WIRINGPI_LIB=${WIRINGPI_LIB}")
message(STATUS "WIRINGPIDEV_LIB=${WIRINGPIDEV_LIB}")

add_executable(gpio ${SRC_FILES})
target_link_libraries(gpio ${WIRINGPIDEV_LIB} ${WIRINGPI_LIB} ${CMAKE_THREAD_LIBS_INIT} -lm -lcrypt -lrt)
install(TARGETS gpio DESTINATION ${CMAKE_INSTALL_PREFIX}/bin)

