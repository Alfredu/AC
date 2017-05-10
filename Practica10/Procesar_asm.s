.text
	.align 4
	.globl procesar
	.type	procesar, @function
	.data

procesar:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$16, %esp
	pushl	%ebx
	pushl	%esi
	pushl	%edi

# Aqui has de introducir el codigo
	movl $0, %ecx # ecx <- i
	movl 8(%ebp), %eax
	movl 12(%ebp), %ebx # mata y matb en eax y ebx
	movl 16(%ebp), %edi
	imul %edi, %edi # <- n²
	for:	cmpl %edi, %ecx
			jge fifor
			imul $16, (%eax, %ecx), %edx
			movb %dl, (%ebx, %ecx)
			incl %ecx
			jmp for
	fifor:


# El final de la rutina ya esta programado

	popl	%edi
	popl	%esi
	popl	%ebx
	movl %ebp,%esp
	popl %ebp
	ret
