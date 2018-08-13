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

project(scrollPhat LANGUAGES C)

set(CMAKE_THREAD_PREFER_PTHREAD TRUE)
find_package(Threads REQUIRED)

find_library(WIRINGPI_LIB wiringPi HINTS "${CMAKE_INSTALL_PREFIX}/lib")
find_library(WIRINGPIDEV_LIB wiringPiDev HINTS "${CMAKE_INSTALL_PREFIX}/lib")

include_directories (.)


if ("${CMAKE_C_COMPILER_ID}" STREQUAL "GNU")
  add_definitions(-D_GNU_SOURCE)
endif()

set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -Wall -Winline -pipe")

message(STATUS "WIRINGPI_LIB=${WIRINGPI_LIB}")
message(STATUS "WIRINGPIDEV_LIB=${WIRINGPIDEV_LIB}")

add_executable(scphat scphat.c)
target_link_libraries(scphat ${WIRINGPIDEV_LIB} ${WIRINGPI_LIB} ${CMAKE_THREAD_LIBS_INIT} -lm -lcrypt -lrt)
install(TARGETS scphat DESTINATION ${CMAKE_INSTALL_PREFIX}/bin)

add_executable(_test test.c)
target_link_libraries(_test ${WIRINGPIDEV_LIB} ${WIRINGPI_LIB} ${CMAKE_THREAD_LIBS_INIT} -lm -lcrypt -lrt)
set_target_properties(_test PROPERTIES OUTPUT_NAME "test")
install(TARGETS _test DESTINATION ${CMAKE_INSTALL_PREFIX}/bin)


