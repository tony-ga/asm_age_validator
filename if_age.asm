section .data
	question db "Cual es tu edad?: "
	question_len equ $ - question

	major db "Eres mayor de edad :)", 10
	major_len equ $ - major

	menor db "Eres menor de edad :(", 10
	menor_len equ $ - menor

section .bss
	age resb 32

section .text
	global _start

_start:
	; ---  Pregunta del sistema ---
	mov rax, 1
	mov rdi, 1
	mov rsi, question
	mov rdx, question_len
	syscall

	; --- Respuesta del usuario ---
	mov rax, 0
	mov rdi, 0
	mov rsi, age
	mov rdx, 16
	syscall

	; ---  Conversion de datos ---
	xor rax, rax
	xor rbx, rbx
	
	; ---  Decodificar primer digito ---
	mov al, [age]
	sub al, 48 
	mov dl, 10
	mul dl

	; --- Decodificar segundo digito ---
	mov bl, [age + 1]
	sub bl, 48
	add al, bl

	; --- Validacion de edad ---
	cmp al, 18	; Es la edad (20)  menor que 18?
	jl is_menor

is_major:
	mov rax, 1
	mov rdi, 1
	mov rsi, major
	mov rdx, major_len
	syscall
	jmp end

is_menor:
	mov rax, 1
	mov rdi, 1
	mov rsi, menor
	mov rdx, menor_len
	syscall

end:
	mov rax, 60
	mov rdi, 0
	syscall
