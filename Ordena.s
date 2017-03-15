 .text
	.align 4
	.globl Ordenar
	.type Ordenar,@function
Ordenar:
        # Aqui viene vuestro codigo
	
	pushl %ebp
	movl %esp, %ebp
	subl $8, %esp

	# Guardamos
	pushl %ebx
	pushl %esi
	pushl %edi

	movl 8(%ebp), %ebx
	movl $0, %esi # esi <- i

	for1:
		imul $12, %esi, %edi # edi <- i*12
		cmpl $0x80000000, 4(%ebx, %edi)
		je fifor1
		movl %esi, %eax
		incl %eax # j <- i+1

		for2:
			pushl %eax

			imul $12, %eax, %ecx
			cmpl $0x80000000, 4(%ebx, %ecx)
			je fifor2

			movl 4(%ebx, %edi), %edx

			cmpl 4(%ebx, %ecx), %edx
			jle fi

			pushl %eax
			pushl %esi
			pushl %ebx
			call Intercambiar
			addl $12, %esp

			fi:
				popl %eax
				incl %eax
				jmp for2
		fifor2:
			incl %esi
			jmp for1
	fifor1:

		movl %esi, %eax


		# Deshacemos

		popl %edi
		popl %esi
		popl %ebx

		movl %ebp, %esp
		popl %ebp
		ret


		
