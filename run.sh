# *****************************************************************************
# Program name: "QuadraticFormula".  This program reads the three coeffeicients
# (a, b, c) of a quadratic equation (a)x^2 + (b)x + (c) = 0 through the
# standard input device.  It then calculates the
# roots of said equation and outputs the result to the standard output device.
# One root is returned.  If there are no real roots, 0 is returned.
# Copyright (C) 2021 Sean Javiya.
#
# This file is part of the software QuadraticFormula                                                                   *
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.
#
# *****************************************************************************
#
#
# -----------------------------------------------------------------------------
# -----------------------------------------------------------------------------
# Author information
#   Author name: Sean Javiya
#   Author email: seanjaviya@csu.fullerton.edu
# Program information
#   Program name: QuadraticFormula
#   Programming languages: One driver module in C, one module in X86, two
#                          library modules in C++, and one bash file
#   Date program began: 2021-Feb-19
#   Date of last update: 2021-Feb-27
#   Date of reorganization of comments: 2021-Feb-27
#   Files in this program: Quad_library.cpp, Quadratic.asm, Second_degree.c,
#                          isfloat.cpp, run.sh
#   Status: Finished.
#   The program was tested extensively with no errors in (Tuffix) Ubuntu 20.04
# Purpose
#   This program assists with assembling, linking, compiling, and running.
#   This program is part of QuadraticFormula, which will calculate the real
#   roots of a quadratic equation.  This program will also be submit (for
#   credit) for an assignment conducted during my graduate studies program.
# This file
#    File name: run.sh
#    Language: shell script
#    Max page width: 132 columns  (this file was not optimized for printing)
#    execute without permissions: sh run.sh
# -----------------------------------------------------------------------------
# -----------------------------------------------------------------------------
#Assemble Quadratic.asm
nasm -f elf64 -l Quadratic.lis -o Quadratic.o Quadratic.asm

#Compile Quad_library.cpp using the gcc compiler
gcc -c -Wall -m64 -no-pie -o Quad_library.o Quad_library.cpp

#Compile isfloat.cpp using the gcc compiler
gcc -c -Wall -m64 -no-pie -o isfloat.o isfloat.cpp

#Compile Second_degree.c using the gcc compiler standard 2011
gcc -c -Wall -m64 -no-pie -o Second_degree.o Second_degree.c -std=c11

#Link the object files using the g++ linker
g++ -m64 -no-pie -o QuadraticFormula.out Second_degree.o isfloat.o Quad_library.o Quadratic.o -std=c11

#Run the program QuadraticFormula:
./QuadraticFormula.out

#echo "The script file will terminate. Have a nice day!"
