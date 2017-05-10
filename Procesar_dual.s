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
	
	movl %eax, %esi
	and $15, %esi
	cmpl $0, %esi
	jne forual

	foral:
		cmpl %edi, %ecx
		jge fiforal
		movl $0, %esi
		movdqa (%eax, %ecx), %xmm1
		suma:
			cmpl $4, %esi
			jge fisuma
			paddb %xmm1, %xmm1
			incl %esi
			jmp suma
		fisuma:
			movdqa %xmm1, (%ebx, %ecx)
			addl $16, %ecx
			jmp foral
	fiforal:
		jmp fifor

	forual:
		cmpl %edi, %ecx
		jge fifor
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
			jmp forual
	fifor:





# El final de la rutina ya esta programado

	emms	# Instruccion necesaria si os equivocais y usais MMX
	popl	%edi
	popl	%esi
	popl	%ebx
	movl %ebp,%esp
	popl %ebp
	ret
