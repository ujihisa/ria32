.file	"test/add.cb"
	.data
	.align	4
	.type	g,@object
	.size	g,4
g:
.long	3
	.section	.rodata
.LC0:
	.string	"%d"
.LC1:
	.string	";%d"
.LC2:
	.string	""
	.text
.globl main
	.type	main,@function
main:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$32, %esp
	movl	$0, %eax
	movl	%eax, -8(%ebp)
	movl	$1, %eax
	addl	$0, %eax
	pushl	%eax
	movl	$.LC0, %eax
	pushl	%eax
	call	printf
	addl	$8, %esp
	movl	$2, %eax
	movl	-8(%ebp), %ecx
	addl	%ecx, %eax
	pushl	%eax
	movl	$.LC1, %eax
	pushl	%eax
	call	printf
	addl	$8, %esp
	movl	$2, %eax
	movl	%eax, -4(%ebp)
	movl	$1, %eax
	movl	%eax, -8(%ebp)
	movl	-4(%ebp), %eax
	movl	-8(%ebp), %ecx
	addl	%ecx, %eax
	pushl	%eax
	movl	$.LC1, %eax
	pushl	%eax
	call	printf
	addl	$8, %esp
	movl	-8(%ebp), %eax
	movl	g, %ecx
	addl	%ecx, %eax
	pushl	%eax
	movl	$.LC1, %eax
	pushl	%eax
	call	printf
	addl	$8, %esp
	movl	-4(%ebp), %eax
	movl	g, %ecx
	addl	%ecx, %eax
	pushl	%eax
	movl	$.LC1, %eax
	pushl	%eax
	call	printf
	addl	$8, %esp
	movl	$5, %eax
	pushl	%eax
	call	f
	addl	$4, %esp
	movl	%eax, -12(%ebp)
	movl	-12(%ebp), %eax
	pushl	%eax
	movl	$.LC1, %eax
	pushl	%eax
	call	printf
	addl	$8, %esp
	movl	$5, %eax
	pushl	%eax
	call	f
	addl	$4, %esp
	movl	%eax, -16(%ebp)
	movl	-16(%ebp), %eax
	addl	$1, %eax
	pushl	%eax
	movl	$.LC1, %eax
	pushl	%eax
	call	printf
	addl	$8, %esp
	movl	$5, %eax
	pushl	%eax
	call	f
	addl	$4, %esp
	movl	%eax, -20(%ebp)
	movl	-20(%ebp), %eax
	movl	-4(%ebp), %ecx
	addl	%ecx, %eax
	pushl	%eax
	movl	$.LC1, %eax
	pushl	%eax
	call	printf
	addl	$8, %esp
	movl	$5, %eax
	movl	%eax, c
	movl	$3, %eax
	pushl	%eax
	call	f
	addl	$4, %esp
	movl	%eax, -24(%ebp)
	movl	-24(%ebp), %eax
	movl	c, %ecx
	addl	%ecx, %eax
	pushl	%eax
	movl	$.LC1, %eax
	pushl	%eax
	call	printf
	addl	$8, %esp
	movl	$9, %eax
	movl	%eax, -4(%ebp)
	movl	-4(%ebp), %eax
	pushl	%eax
	call	f
	addl	$4, %esp
	movl	%eax, -28(%ebp)
	movl	-28(%ebp), %eax
	pushl	%eax
	movl	$.LC1, %eax
	pushl	%eax
	call	printf
	addl	$8, %esp
	movl	$1, %eax
	movl	%eax, -8(%ebp)
	movl	-4(%ebp), %eax
	pushl	%eax
	call	f
	addl	$4, %esp
	movl	%eax, -32(%ebp)
	movl	-32(%ebp), %eax
	movl	-8(%ebp), %ecx
	addl	%ecx, %eax
	pushl	%eax
	movl	$.LC1, %eax
	pushl	%eax
	call	printf
	addl	$8, %esp
	movl	$.LC2, %eax
	pushl	%eax
	call	puts
	addl	$4, %esp
	movl	$0, %eax
	jmp	.L0
.L0:
	movl	%ebp, %esp
	popl	%ebp
	ret
	.size	main,.-main
.globl f
	.type	f,@function
f:
	pushl	%ebp
	movl	%esp, %ebp
	movl	8(%ebp), %eax
	addl	$1, %eax
	jmp	.L1
.L1:
	movl	%ebp, %esp
	popl	%ebp
	ret
	.size	f,.-f
.local c
	.comm	c,4,4
