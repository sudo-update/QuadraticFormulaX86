;******************************************************************************;
;Program name: "QuadraticFormula".  This program reads the three coeffeicients
;(a, b, c) of a quadratic equation (a)x^2 + (b)x + (c) = 0 through the standard
;input device.  It then calculates the
;roots of said equation and outputs the result to the standard output device.
;One root is returned.  If there are no real roots, 0 is returned.
;Copyright (C) 2021 Sean Javiya.                                                                           *
;
; This file is part of the software QuadraticFormula
; This program is free software: you can redistribute it and/or modify
; it under the terms of the GNU General Public License as published by
; the Free Software Foundation, either version 3 of the License, or
; (at your option) any later version.
;
; This program is distributed in the hope that it will be useful,
; but WITHOUT ANY WARRANTY; without even the implied warranty of
; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
; GNU General Public License for more details.
;
; You should have received a copy of the GNU General Public License
; along with this program.  If not, see <https://www.gnu.org/licenses/>.
; *****************************************************************************
;
;
;------------------------------------------------------------------------------;
;------------------------------------------------------------------------------;
;Author information
;  Author name: Sean Javiya
;  Author email: seanjaviya@csu.fullerton.edu
;
;Program information
;  Program name: QuadraticFormula
;  Programming languages: One driver module in C, one module in X86, two library
;                         modules in C++, and one bash file
;  Date program began: 2021-Feb-19
;  Date of last update: 2021-Feb-27
;  Date of reorganization of comments: 2021-Feb-27
;  Files in this program: Quad_library.cpp, Quadratic.asm, Second_degree.c,
;                         isfloat.cpp, run.sh
;  Status: Finished.
;  The program was tested extensively with no errors in (Tuffix) Ubuntu 20.04
;Purpose
;  This program will calculate the real roots of a quadratic equation.  This
;  program will also be submit (for credit) for an assignment conducted during
;  my graduate studies program.
;This file
;   File name: Quadratic.asm
;   Language: X86 with Intel syntax.
;   Max page width: 132 columns  (this file was not optimized for printing out)
;   Assemble:        nasm -f elf64 -l Quadratic.lis -o Quadratic.o Quadratic.asm
;------------------------------------------------------------------------------;
;------------------------------------------------------------------------------;
;extra note: there was a proposed research question in the prompt.  In this
;program, if you input an exceptionally long number as a coefficient (one that
;is so long, it obviously won't fit inside a 64bit register), that number will
;be accepted as a float by isfloat, and then truncated to fit into a 64bit
;register, while preserving the most significant digit.
;Ie: 4.123456789012345678901234567890123456789012345678901234567890
;will still be output (%8.12 was used) as a very similar value of:
;      4.123456789012
;------------------------------------------------------------------------------;
extern show_no_root
extern show_one_root
extern show_two_root
extern atof
extern isfloat
extern printf
extern scanf
global Quadratic
segment .data
welcome db "This program will find the roots of any quadratic equation.", 10, 0
coefficients_prompt db "Please enter the three floating point coefficients of a quadratic equation,", 10, "  including the decimal point (enter 1.0 instead of 1),", 10, "  in the order a, b, c", 10, "  separated by the end of line character:   ", 0
reaffirm_equation db "Thank you.  The equation is:", 10, "    (%8.12lf)x^2  +  (%8.12lf)x  +  (%8.12lf)  =  0.0", 10, 0
goodbye_one_root db "The root will be returned to the caller function.", 10, 0
goodbye_two_roots db "One of these roots will be returned to the caller function.", 10, 0
goodbye_no_roots db "0 will be returned to the caller function", 10, 0
scan_one_string db "%s", 0
unexpected_error_message db "unexpected flow error.", 10, 0
invalid_input_message db "Invalid input data detected.  You may run this program again.", 10, 0
linear_equation_message db "A quadratic equation follows the format: (a)x^2 + (b)x + c = 0", 10, "Where (a) does not equal 0.", 10, "You entered (a) = 0. Hence, the equation is linear.", 10, 0
segment .bss
segment .text
Quadratic:
;------------------------------------------------------------------------------;
;------------------------------------------------------------------------------;
;preserve the registers onto the stack
push rbp
mov  rbp,rsp
push rdi
push rsi
push rdx
push rcx
push r8
push r9
push r10
push r11
push r12
push r13
push r14
push r15
push rbx
pushf
;------------------------------------------------------------------------------;
;------------------------------------------------------------------------------;
;                                                                     BEGIN CODE
;------------------------------------------------------------------------------;
;------------------------------------------------------------------------------;
;say hello
push qword 0
mov rax, 0
mov rdi, welcome ;"This program will find the roots of any quadratic equation.",10
call printf
pop rax
;prompt for values
push qword 0
mov rax, 0
mov rdi, coefficients_prompt ;"Please enter the three floating point coefficients of a quadratic equation,", 10, "  including the decimal point (enter 1.0 instead of 1),", 10, "  in the order a, b, c", 10, "  separated by the end of line character:   "
call printf
pop rax
;------------------------------------------------------------------------------;
;------------------------------------------------------------------------------;
;                               scan block BEGIN
;there are 4 sections of this block.
;1), 2), and 3) scan each float and
;4) checks if we were given a valid quadratic equation
;------------------------------------------------------------------------------;
;------------------------------------------------------------------------------;
;                                    1)
;------------------------------------------------------------------------------;
;scan first value to the stack
sub rsp, 1536
mov rax, 0
mov rdi, scan_one_string ;%s
mov rsi, rsp
call scanf
;check if value on stack is a float
mov rdi, rsp
call isfloat
mov r12, 0
cmp rax, r12
;if value is not a float, jump to invalid_inputs_detected
je invalid_inputs_detected
;else continue. convert string to float and preserve the valid coefficient a
mov rax, 1
mov rdi, rsp
call atof
movsd xmm15, xmm0                   ;xmm15 holds a
add rsp, 1536
;------------------------------------------------------------------------------;
;                                    2)
;------------------------------------------------------------------------------;
;scan second value to the stack
sub rsp, 1536
mov rax, 0
mov rdi, scan_one_string ;%s
mov rsi, rsp
call scanf
;check if value on stack is a float
mov rdi, rsp
call isfloat
mov r12, 0
cmp rax, r12
;if value is not a float, jump to invalid_inputs_detected
je invalid_inputs_detected
;else continue. convert string to float and preserve the valid coefficient b
mov rax, 1
mov rdi, rsp
call atof
movsd xmm14, xmm0                   ;xmm14 holds b
add rsp, 1536
;------------------------------------------------------------------------------;
;                                    3)
;------------------------------------------------------------------------------;
;scan third value onto the stack
sub rsp, 1536
mov rax, 0
mov rdi, scan_one_string ;%s
mov rsi, rsp
call scanf
;check if value on stack is a float
mov rdi, rsp
call isfloat
mov r12, 0
cmp rax, r12
;if value is not a float, jump to invalid_inputs_detected
je invalid_inputs_detected
;else continue. convert string to float and preserve the valid coefficient c
mov rax, 1
mov rdi, rsp
call atof
movsd xmm13, xmm0                   ;xmm13 holds c
add rsp, 1536
;------------------------------------------------------------------------------;
                                    ;4)
;------------------------------------------------------------------------------;
;check if valid quadratic equation
;check if a = 0.  if a = 0, this is not a quadratic equation
cvtsi2sd xmm12, r12
ucomisd xmm15, xmm12
;if a = 0 jump to not_a_quadratic_detected
je not_a_quadratic_detected
;else continue
;------------------------------------------------------------------------------;
;RECAP:
;     xmm15 holds a
;     xmm14 holds b
;     xmm13 holds c
;------------------------------------------------------------------------------;
;------------------------------------------------------------------------------;
;                                  scan block END
;------------------------------------------------------------------------------;
;(we have successfully saved a valid equation from the user)
;------------------------------------------------------------------------------;
;                             calculation block BEGIN
;------------------------------------------------------------------------------;
;------------------------------------------------------------------------------;
;reaffirm the equation
push qword 0
push qword 0
push qword 0
push qword 0
mov rax, 3
mov rdi, reaffirm_equation ;"Thank you.  The equation is:", 10, "    (%8.6lf)x^2  +  (%8.6lf)x  +  (%8.6lf)  =  0.0", 10
movsd xmm0, xmm15 ;a
movsd xmm1, xmm14 ;b
movsd xmm2, xmm13 ;c
call printf
pop rax
pop rax
pop rax
pop rax
;------------------------------------------------------------------------------;
;calculate the dsicriminant:     b^2-4ac
movsd xmm12, xmm14
mulsd xmm12, xmm14                    ;xmm12 holds b^2
mulsd xmm13, xmm15                    ;xmm13 holds ac
mov r15, 4
cvtsi2sd xmm11, r15                   ;xmm11(scratch) holds 4
mulsd xmm13, xmm11                    ;xmm13 holds 4ac
subsd xmm12, xmm13                    ;xmm12 holds discriminant b^2-4ac
movsd xmm13, xmm15
addsd xmm13, xmm15                    ;xmm13 holds 2a
;------------------------------------------------------------------------------;
;compare discriminant to 0 and then decide where to go
mov r15, 0
cvtsi2sd xmm11, r15
ucomisd xmm12, xmm11
;if discrim is 0 jump to discriminant_is_zero
je discriminant_is_zero
;else continue.
;if discrim is positive jump to positive_discriminant
ja positive_discriminant
;else continue
;if discrim is negative jump to negative_discriminant
jb negative_discriminant
;the program should never get here. if it does, we have an unexpected error
;flow exception error.  discrim should = 0, < 0, or > 0
jmp unexpected_error_detected
;------------------------------------------------------------------------------;
;RECAP, current value of xmm12-xmm15:
;     xmm15 holds (a)
;     xmm14 holds (b)
;     xmm13 holds (2a)
;     xmm12 hold (discriminant)
;     and (c) is lost
;we need (a) and we need (b) for calculations
;however we no longer need to preserve (c) after calculating the discriminant
;------------------------------------------------------------------------------;
;------------------------------------------------------------------------------;
;                           calculation block END
;------------------------------------------------------------------------------;
;------------------------------------------------------------------------------;
;                            jump cases block BEGIN
;there are three sections of this block.
;I) calculation jumps and
;II) error jumps
;------------------------------------------------------------------------------;
;------------------------------------------------------------------------------;
;                             I) calculation jumps
;------------------------------------------------------------------------------;
;positive dsicriminant area
;two roots with the following formulas:
;1)     [-b + squareroot(b^2-4ac)]/2a
;2)     [-b - squareroot(b^2-4ac)]/2a
;simplified to
;1)     (-b + sqrt discriminant)/2a
;2)     (-b - sqrt discriminant)/2a
positive_discriminant:
;RECAP, current value of xmm12-xmm15:
;     xmm15 holds (a)
;     xmm14 holds (b)
;     xmm13 holds (2a)
;     xmm12 hold (discriminant)
;calculate squareroot of discriminant
mov r15, -1
cvtsi2sd xmm11, r15  ;xmm11(scratch) holds -1
mulsd xmm14, xmm11   ;xmm14 holds -b
sqrtsd xmm12, xmm12  ;xmm12 holds positive squareroot of discriminant
movsd xmm13, xmm12   ;xmm13 holds positive squareroot of discriminant
mov r15, 2
cvtsi2sd xmm11, r15  ;xmm11(scratch) holds 2
mulsd xmm15, xmm11   ;xmm15 holds 2a
addsd xmm12, xmm14   ;xmm12 holds sqrt(discrim) + -b     [(+) calculation]
subsd xmm14, xmm13   ;xmm14 holds -b - sqrt(discrim)     [(-) calculation]
divsd xmm12, xmm15   ;xmm12 holds root from (+) calculation
divsd xmm14, xmm15   ;xmm14 holds root from (-) calculation
mov rax, 2
movsd xmm0, xmm12
movsd xmm1, xmm14
call show_two_root
;say goodbye
push qword 0
mov rax, 0
mov rdi, goodbye_two_roots ;"One of these roots will be returned to the caller function.", 10
call printf
pop rax
movsd xmm0, xmm12    ;return first root
jmp restore_registers
;------------------------------------------------------------------------------;
;discriminant is equal to 0 area
;one root with the formula of -b/2a
discriminant_is_zero:
;RECAP FROM CALCULATION BLOCK the stable xmm registers current contents are as follows:
;xmm15 holds a
;xmm14 holds b
;xmm13 holds 2a
;xmm12 hold discriminant
;calculate -b/2a
mov r15, -1
cvtsi2sd xmm11, r15                   ;xmm11(scratch) holds
mulsd xmm14, xmm11                    ;xmm14 holds -b
divsd xmm14, xmm13                    ;xmm14 holds the root
mov rax, 1
movsd xmm0, xmm14
call show_one_root
;say goodbye
push qword 0
mov rax, 0
mov rdi, goodbye_one_root ;"The root will be returned to the caller function.", 10
call printf
pop rax
movsd xmm0, xmm14   ;return our root
jmp restore_registers
;------------------------------------------------------------------------------;
;negative discriminant area
negative_discriminant:
;the stable xmm registers current contents are as follows:
;xmm15 holds a
;xmm14 holds b
;xmm13 holds 2a
;xmm12 hold discriminant
;however, no further calculation is necessary for this program's desired functionality
call show_no_root
push qword 0
mov rax, 0
mov rdi, goodbye_no_roots ;"0 will be returned to the caller function", 10
call printf
pop rax
mov rax, 0
cvtsi2sd xmm0, rax
jmp restore_registers
;------------------------------------------------------------------------------;
;                                  II) error jumps
;------------------------------------------------------------------------------;
;unexpected error handling area
unexpected_error_detected:
push qword 0
mov rax, 0
mov rdi, unexpected_error_message ;"unexpected flow error.", 10
call printf
pop rax
;prepare to return 0
mov rax, 0
cvtsi2sd xmm0, rax
jmp restore_registers
;------------------------------------------------------------------------------;
;invalid equation handling area
not_a_quadratic_detected:
push qword 0
mov rax, 0
mov rdi, linear_equation_message ;"A quadratic equation follows the format: (a)x^2 + (b)x + c = 0", 10, "Where (a) does not equal 0.", 10, "You entered (a) = 0. Hence, the equation is linear.", 10
call printf
pop rax
;prepare to return 0
mov rax, 0
cvtsi2sd xmm0, rax
jmp restore_registers
;------------------------------------------------------------------------------;
;invalid input handling area
invalid_inputs_detected:
add rsp, 1536
push qword 0
mov rax, 0
mov rdi, invalid_input_message ;"Invalid input data detected.  You may run this program again.", 10
call printf
pop rax
;prepare to return 0
mov rax, 0
cvtsi2sd xmm0, rax
jmp restore_registers
;------------------------------------------------------------------------------;
;------------------------------------------------------------------------------;
;                                jump block END
;------------------------------------------------------------------------------;
;------------------------------------------------------------------------------;
;                                                                       END CODE
;------------------------------------------------------------------------------;
;------------------------------------------------------------------------------;
restore_registers:
;restore the registers from the stack
popf
pop rbx
pop r15
pop r14
pop r13
pop r12
pop r11
pop r10
pop r9
pop r8
pop rcx
pop rdx
pop rsi
pop rdi
pop rbp
;------------------------------------------------------------------------------;
;return statement
ret
