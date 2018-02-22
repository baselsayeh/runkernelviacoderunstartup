
#define kernelstart 0x480000
#define ramdiskstart 0x8000000

.section .text
.global _start

_start:
	#x21 is the page addr + 0x200
	sub x22, x21, #0x200
	mov x23, x0 //preserve dtb

	/* Check coderun page for kernel */
	add x9, x21, #8
	ldr	x10, [x9]
	cmp	x10, xzr
	beq	skip_kernel
	//

	mov x9, 4096 //skip 4 KB
	add x0, x22, x9
	mov x3, kernelstart
	mov x2, 0x1E00000 //size 30 MB
	add x2, x0, x2
.L1:
	ldr x4, [x0]
	str x4, [x3]
	add x0, x0, 8
	add x3, x3, 8
	cmp x0, x2
	bne .L1

skip_kernel:

	/* Check coderun page for ramdisk */
	add x9, x22, #16
	ldr	x10, [x9]
	cmp	x10, xzr
	beq	skip_ramdisk
	//

	mov x9, 0x2000000 //skip 32 MB
	add x0, x22, x9
	mov x3, ramdiskstart
	mov x2, 0x800000 //size 8 MB
	add x2, x0, x2
.L2:
	ldr x4, [x0]
	str x4, [x3]
	add x0, x0, 8
	add x3, x3, 8
	cmp x0, x2
	bne .L2

skip_ramdisk:

	mov	x0, x23
	mov	x1, xzr
	mov	x2, xzr
	mov	x3, xzr

	mov x9, kernelstart
	br x9

