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
coefficients_prompt db "Please enter the three floating point coefficients of a quadratic equation in the order a, b, c separated by the end of line character:   ", 0
reaffirm_equation db "Thank you.  The equation is  (%8.6lf)x^2  +  (%8.6lf)x  +  (%8.6lf)  =  0.0", 10, 0
reaffirm_equation_string db "Thank you.  The equation is  (%s)x^2  +  (%s)x  +  (%s)  =  0.0", 10, 0
goodbye db "One of these roots will be returned to the caller function.", 10, 0
scan_three_strings db "%s %s %s", 0
error_info_message db "Invalid input data detected.  You may run this program again.", 10, 0
segment .bss
segment .text
Quadratic:
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
;BEEGIN CODE

;say hi
push qword 0
mov rax, 0
mov rdi, welcome
call printf
pop rax
;prompt for values
push qword 0
mov rax, 0
mov rdi, coefficients_prompt
call printf
pop rax
;scan the values
push qword 0
push qword 0
push qword 0
push qword 0
mov rax, 0
mov rdi, scan_three_strings
mov rsi, rsp
mov rdx, rsp
add rdx, 8
mov rcx, rsp
add rcx, 16
call scanf
pop r15                          ;r15 holds a
pop r14                          ;r14 holds b
pop r13                          ;r13 hold c
pop rax
;TODO
;turn strings into floats with atof
;input vaildation
;reaffirm the equation
;perform calculation
;decide which showroot to use
;finally, do this jump vvv
jmp end_of_assembly_program

;invalid input handling area
invalid_inputs_detected:
push qword 0
mov rax, 0
mov rdi, error_info_message
call printf
pop rax
;prepare to return 0
mov rax, 0
cvtsi2sd xmm0, rax
jmp end_of_assembly_program

;END CODE
end_of_assembly_program:
;say bye
push qword 0
mov rax, 0
mov rdi, goodbye
call printf
pop rax

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

;value 0 will be returned
ret
