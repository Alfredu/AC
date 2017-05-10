.text
	.align 4
	.globl procesar
	.type	procesar, @function

procesar:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$16, %esp
	pushl	%ebx
	pushl	%esi
	pushl	%edi

# Aqui has de introducir el codigo
	movl 8(%ebp), %eax
	movl 12(%ebp), %ebx
	movl 16(%ebp), %edi
	imul %edi, %edi
	movl $0, %ecx # ecx <- i
	for:
		cmpl %edi, %ecx
		jge fifor
		movdqu zeros, %xmm0
		movl $0, %esi
		movdqu (%eax, %ecx), %xmm1
		suma:
			cmpl $4, %esi
			jge fisuma
			paddb %xmm1, %xmm1
			incl %esi
			jmp suma
		fisuma:
			movdqu %xmm1, (%ebx, %ecx)
			addl $16, %ecx
			jmp for
	fifor:





# El final de la rutina ya esta programado

	emms	# Instruccion necesaria si os equivocais y usais MMX
	popl	%edi
	popl	%esi
	popl	%ebx
	movl %ebp,%esp
	popl %ebp
	ret
