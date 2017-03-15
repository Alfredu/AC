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
			pushl %eax # Guardamos eax en la pila para que la subrutina no lo modifique
			imul $12, %eax, %ecx # ecx <- j * 12

			cmpl $0x80000000, 4(%ebx, %ecx)
			je fifor2

			movl 4(%ebx, %edi), %edx # edx <- v[i].k

			cmpl 4(%ebx, %ecx), %edx # Comparamos v[i].k con v[j].k
			jle fi

			pushl %eax # Paso
			pushl %esi # De
			pushl %ebx # Parametros
			
			call Intercambiar 
			addl $12, %esp # Quitamos los parametros

			fi:
				popl %eax # Recuperamos la j
				incl %eax
				jmp for2
		fifor2:
			incl %esi
			jmp for1
	fifor1:

		movl %esi, %eax # return i


		# Deshacemos

		popl %edi
		popl %esi
		popl %ebx

		movl %ebp, %esp
		popl %ebp
		
		ret


		
