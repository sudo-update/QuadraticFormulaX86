// *****************************************************************************
// Program name: "QuadraticFormula".  This program reads the three coeffeicients
// (a, b, c) of a quadratic equation (a)x^2 + (b)x + (c) = 0 through the
// standard input device.  It then calculates the
// roots of said equation and outputs the result to the standard output device.
// One root is returned.  If there are no real roots, 0 is returned.
// Copyright (C) 2021 Sean Javiya.
//
// This file is part of the software QuadraticFormula                                                                   *
// QuadraticFormula is free software: you can redistribute it and/or modify it
// under the terms of the GNU Lesser General Public License version 3 as
// published by the Free Software Foundation.  This program is distributed in
// the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the
// implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
// See the GNU Lesser General Public License for more details.  A copy of the
// GNU Lesser General Public License 3.0 should have been distributed with this
// function.  If the LGPL does not accompany this software then it is available
// here:
// <https:;www.gnu.org/licenses/>.
// *****************************************************************************
//
//
// -----------------------------------------------------------------------------
// -----------------------------------------------------------------------------
// Author information
//   Author name: Sean Javiya
//   Author email: seanjaviya@csu.fullerton.edu
//
// Program information
//   Program name: QuadraticFormula
//   Programming languages: One driver module in C, one module in X86, two
//                          library modules in C++, and one bash file
//   Date program began: 2021-Feb-19
//   Date of last update: 2021-Feb-27
//   Date of reorganization of comments: 2021-Feb-27
//   Files in this program: Quad_library.cpp, Quadratic.asm, Second_degree.c,
//                          isfloat.cpp, build.sh
//   Status: Finished.
//   The program was tested extensively with no errors in (Tuffix) Ubuntu 20.04
// Purpose
//   This program is a library of three basic print functions.
//   This program is called by Quadratic, which will calculate the real roots of
//   a quadratic equation.  This program will also be submit (for credit) for an
//   assignment conducted during my graduate studies program.
// This file
//    File name: Quad_library.cpp
//    Language: C++
//    Max page width: 132 columns  (this file was not optimized for printing)
//    Compile:
//         gcc -c -Wall -m64 -no-pie -o Quad_library.o Quad_library.cpp
//    Link:
//         g++ -m64 -no-pie -o QuadraticFormula.out Second_degree.o isfloat.o Quad_library.o Quadratic.o -std=c11
//
// -----------------------------------------------------------------------------
// -----------------------------------------------------------------------------
#include <stdio.h>
#include <cstdlib>
extern "C" void show_no_root();
extern "C" void show_one_root(double root);
extern "C" void show_two_root(double root1, double root2);

void show_no_root() {
  printf("This equation has no real roots.\n");
}
void show_one_root(double root) {
  printf("The root of this equation is:\n   %8.12lf\n", root);
}
void show_two_root(double root1, double root2) {
  printf("The roots of this equation are:\n   %8.12lf   and   %8.12lf\n", root1, root2);
}
