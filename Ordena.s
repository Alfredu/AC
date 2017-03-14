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
	pushl %ecx

	movl 8(%ebp), %ebx
	movl $0, -8(%ebp)
	
	movl -8(%ebp), %ecx # ecx <- i
	for:
		imul $12, %ecx, %esi
		

	# Deshacemos
