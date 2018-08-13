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

project(libwiringPi LANGUAGES C)

set(CMAKE_THREAD_PREFER_PTHREAD TRUE)
find_package(Threads REQUIRED)

set(SRC_FILES
        wiringPi.c
		wiringSerial.c wiringShift.c
		piHiPri.c piThread.c
		wiringPiSPI.c wiringPiI2C.c
		softPwm.c softTone.c
		mcp23008.c mcp23016.c mcp23017.c
		mcp23s08.c mcp23s17.c
		sr595.c
		pcf8574.c pcf8591.c
		mcp3002.c mcp3004.c mcp4802.c mcp3422.c
		max31855.c max5322.c ads1115.c
		sn3218.c
		bmp180.c htu21d.c ds18b20.c rht03.c
		drcSerial.c drcNet.c
		pseudoPins.c
		wpiExtensions.c
)

include_directories (.)


if ("${CMAKE_C_COMPILER_ID}" STREQUAL "GNU")
  add_definitions(-D_GNU_SOURCE)
endif()

set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -Wformat=2 -Wall -Wextra -Winline -pipe -fPIC")


add_library (wiringPi SHARED ${SRC_FILES})
target_link_libraries(wiringPi ${CMAKE_THREAD_LIBS_INIT} -lcrypt -lm -lrt)
install(TARGETS wiringPi DESTINATION ${CMAKE_INSTALL_PREFIX}/lib)

add_library (wiringPi_static STATIC ${SRC_FILES})
set_target_properties(wiringPi_static PROPERTIES OUTPUT_NAME "wiringPi")
install(TARGETS wiringPi_static DESTINATION ${CMAKE_INSTALL_PREFIX}/lib)

