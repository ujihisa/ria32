.file	"test/alloca.cb"
	.section	.rodata
.LC0:
	.string	"Hello"
.LC1:
	.string	"<<%s>>\n"
	.text
.globl main
	.type	main,@function
main:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$8, %esp
	movl	$32, %eax
	pushl	%eax
	call	alloca
	addl	$4, %esp
	movl	%eax, -8(%ebp)
	movl	-8(%ebp), %eax
	movl	%eax, -4(%ebp)
	movl	$.LC0, %eax
	pushl	%eax
	movl	-4(%ebp), %eax
	pushl	%eax
	call	strcpy
	addl	$8, %esp
	movl	-4(%ebp), %eax
	pushl	%eax
	movl	$.LC1, %eax
	pushl	%eax
	call	printf
	addl	$8, %esp
	movl	$0, %eax
	jmp	.L0
.L0:
	movl	%ebp, %esp
	popl	%ebp
	ret
	.size	main,.-main
