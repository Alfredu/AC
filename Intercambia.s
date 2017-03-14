 .text
	.align 4
	.globl Intercambiar
	.type Intercambiar,@function
Intercambiar:
        # Aqui viene vuestro codigo
	pushl %ebp
	movl %esp, %ebp
	subl $12, %esp
	# Guardamos
	pushl %ebx
	pushl %esi

	imul $12, 12(%ebp), %ecx # ecx<- i*12
	imul $12, 16(%ebp), %edx # edx<- j*12
	movl 8(%ebp), %ebx # ebx <-@v[0]


	movb (%ebx, %ecx), %al # al = v[i].c
	movb %al, -4(%ebp) # s = v[i].c

	movb (%ebx, %edx), %ah # al <- v[j].c
	movb %ah, (%ebx, %ecx) # v[i].c = v[j].c 

	movb %al, (%ebx, %edx) # v[j].c = s



	movl 4(%ebx, %ecx), %eax
	movl %eax, -12(%ebp) # tmp = v[i].k

	movl 4(%ebx, %edx), %esi # esi <- v[j].k
	movl %esi, 4(%ebx, %ecx) # v[i].k <- v[j].k

	movl %eax, 4(%ebx, %edx) # v[j].k = tmp;




	movl 8(%ebx, %ecx), %eax
	movl %eax, -8(%ebp) # aux = v[i].m

	movl 8(%ebx, %edx), %esi # esi <- v[j].m
	movl %esi, 8(%ebx, %ecx) # v[i].m <- v[j].m

	movl %eax, 8(%ebx, %edx) # v[j].m = aux;



	popl %esi
	popl %ebx
	movl %ebp, %esp
	popl %ebp
	ret
