	.file	"Procesar.c"
	.text
	.p2align 4,,15
	.globl	procesar
	.type	procesar, @function
procesar:
.LFB0:
	.cfi_startproc
	pushl	%edi
	.cfi_def_cfa_offset 8
	.cfi_offset 7, -8
	pushl	%esi
	.cfi_def_cfa_offset 12
	.cfi_offset 6, -12
	xorl	%edi, %edi
	pushl	%ebx
	.cfi_def_cfa_offset 16
	.cfi_offset 3, -16
	movl	24(%esp), %ecx
	movl	16(%esp), %esi
	movl	20(%esp), %ebx
	testl	%ecx, %ecx
	jle	.L1
	.p2align 4,,10
	.p2align 3
.L6:
	xorl	%eax, %eax
	.p2align 4,,10
	.p2align 3
.L4:
	movzbl	(%esi,%eax), %edx
	sall	$4, %edx
	movb	%dl, (%ebx,%eax)
	addl	$1, %eax
	cmpl	%eax, %ecx
	jne	.L4
	addl	$1, %edi
	addl	%ecx, %esi
	addl	%ecx, %ebx
	cmpl	%edi, %ecx
	jne	.L6
.L1:
	popl	%ebx
	.cfi_restore 3
	.cfi_def_cfa_offset 12
	popl	%esi
	.cfi_restore 6
	.cfi_def_cfa_offset 8
	popl	%edi
	.cfi_restore 7
	.cfi_def_cfa_offset 4
	ret
	.cfi_endproc
.LFE0:
	.size	procesar, .-procesar
	.ident	"GCC: (Ubuntu 6.2.0-5ubuntu12) 6.2.0 20161005"
	.section	.note.GNU-stack,"",@progbits
