	.file	"batt_update.c"
	.text
	.globl	set_batt_from_ports
	.type	set_batt_from_ports, @function
set_batt_from_ports:
.LFB0:
	.cfi_startproc
	endbr64
	movswl	BATT_VOLTAGE_PORT(%rip), %eax
	testl	%eax, %eax
	js	.L7
	sarl	%eax
	movw	%ax, (%rdi)
	cmpw	$2999, %ax
	jg	.L3
	movb	$0, 2(%rdi)
.L4:
	cmpb	$100, 2(%rdi)
	jle	.L5
	movb	$100, 2(%rdi)
.L5:
	testb	$16, BATT_STATUS_PORT(%rip)
	je	.L6
	movb	$1, 3(%rdi)
	movl	$0, %eax
	ret
.L3:
	subl	$3000, %eax
	sarl	$3, %eax
	movb	%al, 2(%rdi)
	jmp	.L4
.L6:
	movb	$2, 3(%rdi)
	movl	$0, %eax
	ret
.L7:
	movl	$1, %eax
	ret
	.cfi_endproc
.LFE0:
	.size	set_batt_from_ports, .-set_batt_from_ports
	.globl	set_display_from_batt
	.type	set_display_from_batt, @function
set_display_from_batt:
.LFB1:
	.cfi_startproc
	endbr64
	subq	$72, %rsp
	.cfi_def_cfa_offset 80
	movq	%fs:40, %rax
	movq	%rax, 56(%rsp)
	xorl	%eax, %eax
	movl	$63, (%rsp)
	movl	$6, 4(%rsp)
	movl	$91, 8(%rsp)
	movl	$79, 12(%rsp)
	movl	$102, 16(%rsp)
	movl	$109, 20(%rsp)
	movl	$125, 24(%rsp)
	movl	$7, 28(%rsp)
	movl	$127, 32(%rsp)
	movl	$111, 36(%rsp)
	movl	$0, 40(%rsp)
	movswl	%di, %r10d
	addl	$5, %r10d
	movl	%edi, %ecx
	sall	$8, %ecx
	movl	%ecx, %r8d
	sarl	$24, %r8d
	movl	%r8d, %ecx
	movslq	%r8d, %rax
	imulq	$1374389535, %rax, %r9
	sarq	$37, %r9
	movl	%r8d, %edx
	sarl	$31, %edx
	subl	%edx, %r9d
	imulq	$1717986919, %rax, %rax
	sarq	$34, %rax
	subl	%edx, %eax
	movslq	%eax, %rdx
	imulq	$1717986919, %rdx, %rdx
	sarq	$34, %rdx
	movl	%eax, %r11d
	sarl	$31, %r11d
	subl	%r11d, %edx
	leal	(%rdx,%rdx,4), %edx
	addl	%edx, %edx
	movl	%eax, %r11d
	subl	%edx, %r11d
	leal	(%rax,%rax,4), %eax
	addl	%eax, %eax
	subl	%eax, %ecx
	movl	%r9d, %eax
	orl	%r11d, %eax
	je	.L18
	movl	%r11d, %edx
	testl	%r9d, %r9d
	jne	.L9
	movl	$10, %r9d
	jmp	.L9
.L18:
	movl	$10, %edx
	movl	$10, %r9d
.L9:
	sarl	$24, %edi
	cmpb	$1, %dil
	je	.L21
	movslq	%r10d, %rax
	imulq	$1717986919, %rax, %rdx
	sarq	$34, %rdx
	sarl	$31, %r10d
	subl	%r10d, %edx
	imulq	$274877907, %rax, %rax
	sarq	$38, %rax
	subl	%r10d, %eax
	movl	%eax, %edi
	movslq	%edx, %rcx
	imulq	$1717986919, %rcx, %rcx
	sarq	$34, %rcx
	movl	%edx, %eax
	sarl	$31, %eax
	subl	%eax, %ecx
	movslq	%ecx, %rax
	imulq	$1717986919, %rax, %rax
	sarq	$34, %rax
	movl	%ecx, %r9d
	sarl	$31, %r9d
	subl	%r9d, %eax
	leal	(%rax,%rax,4), %eax
	addl	%eax, %eax
	movl	%ecx, %r10d
	subl	%eax, %r10d
	movl	%r10d, %eax
	leal	(%rcx,%rcx,4), %ecx
	addl	%ecx, %ecx
	subl	%ecx, %edx
	movslq	%edi, %rcx
	movl	(%rsp,%rcx,4), %ecx
	sall	$17, %ecx
	cltq
	movl	(%rsp,%rax,4), %eax
	sall	$10, %eax
	orl	%ecx, %eax
	movslq	%edx, %rdx
	movl	(%rsp,%rdx,4), %edx
	sall	$3, %edx
	orl	%edx, %eax
	orl	$6, %eax
	movl	%eax, (%rsi)
.L11:
	movsbl	%r8b, %r8d
	cmpl	$5, %r8d
	jbe	.L12
	leal	-6(%r8), %eax
	cmpl	$23, %eax
	ja	.L13
	orl	$16777216, (%rsi)
.L12:
	movq	56(%rsp), %rax
	xorq	%fs:40, %rax
	jne	.L22
	movl	$0, %eax
	addq	$72, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	ret
.L21:
	.cfi_restore_state
	movslq	%r9d, %r9
	movl	(%rsp,%r9,4), %eax
	sall	$17, %eax
	movslq	%edx, %rdx
	movl	(%rsp,%rdx,4), %edx
	sall	$10, %edx
	orl	%edx, %eax
	movslq	%ecx, %rcx
	movl	(%rsp,%rcx,4), %edx
	sall	$3, %edx
	orl	%edx, %eax
	orl	$1, %eax
	movl	%eax, (%rsi)
	jmp	.L11
.L13:
	leal	-30(%r8), %eax
	cmpl	$19, %eax
	ja	.L14
	orl	$50331648, (%rsi)
	jmp	.L12
.L14:
	leal	-50(%r8), %eax
	cmpl	$19, %eax
	ja	.L15
	orl	$117440512, (%rsi)
	jmp	.L12
.L15:
	leal	-70(%r8), %eax
	cmpl	$19, %eax
	ja	.L16
	orl	$251658240, (%rsi)
	jmp	.L12
.L16:
	subl	$90, %r8d
	cmpl	$10, %r8d
	ja	.L12
	orl	$520093696, (%rsi)
	jmp	.L12
.L22:
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE1:
	.size	set_display_from_batt, .-set_display_from_batt
	.globl	batt_update
	.type	batt_update, @function
batt_update:
.LFB2:
	.cfi_startproc
	endbr64
	pushq	%rbx
	.cfi_def_cfa_offset 16
	.cfi_offset 3, -16
	subq	$16, %rsp
	.cfi_def_cfa_offset 32
	movq	%fs:40, %rax
	movq	%rax, 8(%rsp)
	xorl	%eax, %eax
	movw	$-100, 4(%rsp)
	movb	$-1, 6(%rsp)
	movb	$-1, 7(%rsp)
	leaq	4(%rsp), %rdi
	call	set_batt_from_ports
	testl	%eax, %eax
	je	.L28
	movl	$1, %ebx
.L23:
	movq	8(%rsp), %rax
	xorq	%fs:40, %rax
	jne	.L29
	movl	%ebx, %eax
	addq	$16, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 16
	popq	%rbx
	.cfi_def_cfa_offset 8
	ret
.L28:
	.cfi_restore_state
	movl	%eax, %ebx
	leaq	BATT_DISPLAY_PORT(%rip), %rsi
	movl	4(%rsp), %edi
	call	set_display_from_batt
	jmp	.L23
.L29:
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE2:
	.size	batt_update, .-batt_update
	.ident	"GCC: (Ubuntu 9.4.0-1ubuntu1~20.04.1) 9.4.0"
	.section	.note.GNU-stack,"",@progbits
	.section	.note.gnu.property,"a"
	.align 8
	.long	 1f - 0f
	.long	 4f - 1f
	.long	 5
0:
	.string	 "GNU"
1:
	.align 8
	.long	 0xc0000002
	.long	 3f - 2f
2:
	.long	 0x3
3:
	.align 8
4:
