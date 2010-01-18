.file	"test/array.cb"
	.section	.rodata
.LC0:
	.string	"%d;%d;%d\n"
	.text
.globl main
	.type	main,@function
main:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$20, %esp
	movl	$4, %eax
	imull	$0, %eax
	movl	%eax, %ecx
	leal	-20(%ebp), %eax
	addl	%ecx, %eax
	movl	%eax, %ecx
	movl	$1, %eax
	movl	%eax, (%ecx)
	movl	$4, %eax
	imull	$1, %eax
	movl	%eax, %ecx
	leal	-20(%ebp), %eax
	addl	%ecx, %eax
	movl	%eax, %ecx
	movl	$3, %eax
	movl	%eax, (%ecx)
	movl	$4, %eax
	imull	$2, %eax
	movl	%eax, %ecx
	leal	-20(%ebp), %eax
	addl	%ecx, %eax
	movl	%eax, %ecx
	movl	$5, %eax
	movl	%eax, (%ecx)
	movl	$4, %eax
	imull	$3, %eax
	movl	%eax, %ecx
	leal	-20(%ebp), %eax
	addl	%ecx, %eax
	movl	%eax, %ecx
	movl	$7, %eax
	movl	%eax, (%ecx)
	movl	$4, %eax
	imull	$4, %eax
	movl	%eax, %ecx
	leal	-20(%ebp), %eax
	addl	%ecx, %eax
	movl	%eax, %ecx
	movl	$9, %eax
	movl	%eax, (%ecx)
	movl	$4, %eax
	imull	$4, %eax
	movl	%eax, %ecx
	leal	-20(%ebp), %eax
	addl	%ecx, %eax
	movl	(%eax), %eax
	pushl	%eax
	movl	$4, %eax
	imull	$2, %eax
	movl	%eax, %ecx
	leal	-20(%ebp), %eax
	addl	%ecx, %eax
	movl	(%eax), %eax
	pushl	%eax
	movl	$4, %eax
	imull	$0, %eax
	movl	%eax, %ecx
	leal	-20(%ebp), %eax
	addl	%ecx, %eax
	movl	(%eax), %eax
	pushl	%eax
	movl	$.LC0, %eax
	pushl	%eax
	call	printf
	addl	$16, %esp
	movl	$0, %eax
	jmp	.L0
.L0:
	movl	%ebp, %esp
	popl	%ebp
	ret
	.size	main,.-main
