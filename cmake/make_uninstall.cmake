#
# make_uninstall.cmake:
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

if(NOT EXISTS "${CMAKE_CURRENT_BINARY_DIR}/install_manifest.txt")
    message(FATAL_ERROR "Cannot find install manifest: ${CMAKE_CURRENT_BINARY_DIR}/install_manifest.txt")
endif()

file(READ "${CMAKE_CURRENT_BINARY_DIR}/install_manifest.txt" files)
string(REGEX REPLACE "[\r\n]" ";" files "${files}")

foreach(file ${files})
    message(STATUS "Uninstalling ${file}")
    if(EXISTS "${file}")
        file(REMOVE ${file})
        if (EXISTS "${file}")
            message(FATAL_ERROR "Problem when removing ${file}, please check your permissions")
        endif()
    else()
        message(STATUS "File ${file} does not exist.")
    endif()
endforeach()
