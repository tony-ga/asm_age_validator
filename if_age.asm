section .data
	question db "Cual es tu edad?: "
	question_len equ $ - question

	major db "Eres mayor de edad :)", 10
	major_len equ $ - major

	menor db "Eres menor de edad :(", 10
	menor_len equ $ - menor

section .bss
	age resb 10

section .text
	global _start

_start:
	; 1. Pregunta del sistema
	mov rax, 1
	mov rdi, 1
	mov rsi, question
	mov rdx, question_len
	syscall

	; 2. Respuesta del usuario
	mov rax, 0
	mov rdi, 0
	mov rsi, age
	mov rdx, 10
	syscall

	; 3. Limpiar registros antes del bucle
	xor rax, rax	; RAX sera el cumulador
	mov rsi, age	; RSI apunta al inicio de los datos

bucle_conversion:
	movzx rbx, byte [rsi]
	cmp bl, 10	; Es bl == enter?, (10 == \n)
	je finalizar_loop	; Si es enter, saltamos a comparar

	sub bl, 48	; ASCII a valor real
	imul rax, 10	; Acumulador x 10
	add rax, rbx	; Sumar el nuevo digito
	
finalizar_loop:
	; Ahora RAX tiene el numero real
	cmp rax, 18
	jl is_menor	; si RAX < 18, salta a menor

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
