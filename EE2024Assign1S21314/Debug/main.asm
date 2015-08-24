   1              		.syntax unified
   2              		.cpu cortex-m3
   3              		.fpu softvfp
   4              		.eabi_attribute 20, 1
   5              		.eabi_attribute 21, 1
   6              		.eabi_attribute 23, 3
   7              		.eabi_attribute 24, 1
   8              		.eabi_attribute 25, 1
   9              		.eabi_attribute 26, 1
  10              		.eabi_attribute 30, 6
  11              		.eabi_attribute 18, 4
  12              		.thumb
  13              		.file	"main.c"
  23              	.Ltext0:
  24              		.file 1 "../src/main.c"
 655              		.align	2
 656              	loop.1116:
 657 0000 00000000 		.space	4
 658              		.section	.rodata
 659              		.align	2
 660              	.LC0:
 661 0000 496E6974 		.ascii	"Initial value of x (press [Enter] after keying in):"
 661      69616C20 
 661      76616C75 
 661      65206F66 
 661      20782028 
 662 0033 2000     		.ascii	" \000"
 663 0035 000000   		.align	2
 664              	.LC1:
 665 0038 256600   		.ascii	"%f\000"
 666 003b 00       		.align	2
 667              	.LC2:
 668 003c 41524D20 		.ascii	"ARM ASM & Integer version:\012\000"
 668      41534D20 
 668      2620496E 
 668      74656765 
 668      72207665 
 669              		.global	__aeabi_f2iz
 670              		.global	__aeabi_i2f
 671              		.global	__aeabi_f2d
 672              		.align	2
 673              	.LC3:
 674 0058 78736F6C 		.ascii	"xsol : %f \012\012\000"
 674      203A2025 
 674      66200A0A 
 674      00
 675 0065 000000   		.align	2
 676              	.LC4:
 677 0068 43202620 		.ascii	"C & Floating point version:\012\000"
 677      466C6F61 
 677      74696E67 
 677      20706F69 
 677      6E742076 
 678              		.global	__aeabi_fmul
 679              		.global	__aeabi_fadd
 680 0085 000000   		.align	2
 681              	.LC5:
 682 0088 783A2025 		.ascii	"x: %f, fp: %f, change: %f\012\000"
 682      662C2066 
 682      703A2025 
 682      662C2063 
 682      68616E67 
 683              		.global	__aeabi_fcmpeq
 684 00a3 00       		.section	.text.main,"ax",%progbits
 685              		.align	2
 686              		.global	main
 687              		.thumb
 688              		.thumb_func
 690              	main:
 691              	.LFB2:
   1:../src/main.c **** #include "stdio.h"
   2:../src/main.c **** 
   3:../src/main.c **** // EE2024 Assignment 1
   4:../src/main.c **** // (C) CK Tham, ECE, NUS, 2014
   5:../src/main.c **** 
   6:../src/main.c **** // Optimization routine written in assembly language
   7:../src/main.c **** // Input parameters (signed integers):
   8:../src/main.c **** //     xi : integer version of x
   9:../src/main.c **** //     a, b, c : integer coefficients of f(x)
  10:../src/main.c **** // Output : returns solution x (signed integer)
  11:../src/main.c **** extern int optimize(int xi, int a, int b, int c);
  12:../src/main.c **** 
  13:../src/main.c **** int main(void)
  14:../src/main.c **** {
 692              		.loc 1 14 0
 693              		@ args = 0, pretend = 0, frame = 40
 694              		@ frame_needed = 1, uses_anonymous_args = 0
 695 0000 2DE9B043 		push	{r4, r5, r7, r8, r9, lr}
 696              	.LCFI0:
 697 0004 8EB0     		sub	sp, sp, #56
 698              	.LCFI1:
 699 0006 04AF     		add	r7, sp, #16
 700              	.LCFI2:
  15:../src/main.c ****     int a=2, b=-3, c=3, xsoli;
 701              		.loc 1 15 0
 702 0008 4FF00203 		mov	r3, #2
 703 000c 7B60     		str	r3, [r7, #4]
 704 000e 6FF00203 		mvn	r3, #2
 705 0012 BB60     		str	r3, [r7, #8]
 706 0014 4FF00303 		mov	r3, #3
 707 0018 FB60     		str	r3, [r7, #12]
  16:../src/main.c ****     float fp, x, xprev, xsol, change, lambda=0.2;
 708              		.loc 1 16 0
 709 001a 4E4B     		ldr	r3, .L5	@ float
 710 001c 7B62     		str	r3, [r7, #36]	@ float
  17:../src/main.c **** 
  18:../src/main.c ****     printf("Initial value of x (press [Enter] after keying in): "); // try x0 = -12.35
 711              		.loc 1 18 0
 712 001e 40F20000 		movw	r0, #:lower16:.LC0
 713 0022 C0F20000 		movt	r0, #:upper16:.LC0
 714 0026 FFF7FEFF 		bl	printf
  19:../src/main.c ****     scanf("%f", &x);
 715              		.loc 1 19 0
 716 002a 3B46     		mov	r3, r7
 717 002c 40F20000 		movw	r0, #:lower16:.LC1
 718 0030 C0F20000 		movt	r0, #:upper16:.LC1
 719 0034 1946     		mov	r1, r3
 720 0036 FFF7FEFF 		bl	scanf
  20:../src/main.c **** 
  21:../src/main.c **** //  ARM ASM & Integer version
  22:../src/main.c ****     printf("ARM ASM & Integer version:\n");
 721              		.loc 1 22 0
 722 003a 40F20000 		movw	r0, #:lower16:.LC2
 723 003e C0F20000 		movt	r0, #:upper16:.LC2
 724 0042 FFF7FEFF 		bl	printf
  23:../src/main.c ****     xsoli = optimize((int)x,a,b,c);
 725              		.loc 1 23 0
 726 0046 3B68     		ldr	r3, [r7, #0]	@ float
 727 0048 1846     		mov	r0, r3
 728 004a FFF7FEFF 		bl	__aeabi_f2iz
 729 004e 0346     		mov	r3, r0
 730 0050 1846     		mov	r0, r3
 731 0052 7968     		ldr	r1, [r7, #4]
 732 0054 BA68     		ldr	r2, [r7, #8]
 733 0056 FB68     		ldr	r3, [r7, #12]
 734 0058 FFF7FEFF 		bl	optimize
 735 005c 0346     		mov	r3, r0
 736 005e 3B61     		str	r3, [r7, #16]
  24:../src/main.c ****     xsol = xsoli;
 737              		.loc 1 24 0
 738 0060 3869     		ldr	r0, [r7, #16]
 739 0062 FFF7FEFF 		bl	__aeabi_i2f
 740 0066 0346     		mov	r3, r0
 741 0068 FB61     		str	r3, [r7, #28]	@ float
  25:../src/main.c ****     printf("xsol : %f \n\n",xsol);
 742              		.loc 1 25 0
 743 006a F869     		ldr	r0, [r7, #28]	@ float
 744 006c FFF7FEFF 		bl	__aeabi_f2d
 745 0070 0246     		mov	r2, r0
 746 0072 0B46     		mov	r3, r1
 747 0074 40F20000 		movw	r0, #:lower16:.LC3
 748 0078 C0F20000 		movt	r0, #:upper16:.LC3
 749 007c FFF7FEFF 		bl	printf
  26:../src/main.c **** 
  27:../src/main.c **** //  C & Floating Point version
  28:../src/main.c ****   	printf("C & Floating point version:\n",x);
 750              		.loc 1 28 0
 751 0080 3B68     		ldr	r3, [r7, #0]	@ float
 752 0082 1846     		mov	r0, r3
 753 0084 FFF7FEFF 		bl	__aeabi_f2d
 754 0088 0246     		mov	r2, r0
 755 008a 0B46     		mov	r3, r1
 756 008c 40F20000 		movw	r0, #:lower16:.LC4
 757 0090 C0F20000 		movt	r0, #:upper16:.LC4
 758 0094 FFF7FEFF 		bl	printf
 759              	.L3:
  29:../src/main.c ****     while (1)
  30:../src/main.c ****     {
  31:../src/main.c ****     	fp = 2*a*x + b;
 760              		.loc 1 31 0
 761 0098 7B68     		ldr	r3, [r7, #4]
 762 009a 4FEA4303 		lsl	r3, r3, #1
 763 009e 1846     		mov	r0, r3
 764 00a0 FFF7FEFF 		bl	__aeabi_i2f
 765 00a4 0346     		mov	r3, r0
 766 00a6 3A68     		ldr	r2, [r7, #0]	@ float
 767 00a8 1846     		mov	r0, r3
 768 00aa 1146     		mov	r1, r2
 769 00ac FFF7FEFF 		bl	__aeabi_fmul
 770 00b0 0346     		mov	r3, r0
 771 00b2 1C46     		mov	r4, r3
 772 00b4 B868     		ldr	r0, [r7, #8]
 773 00b6 FFF7FEFF 		bl	__aeabi_i2f
 774 00ba 0346     		mov	r3, r0
 775 00bc 2046     		mov	r0, r4
 776 00be 1946     		mov	r1, r3
 777 00c0 FFF7FEFF 		bl	__aeabi_fadd
 778 00c4 0346     		mov	r3, r0
 779 00c6 7B61     		str	r3, [r7, #20]	@ float
  32:../src/main.c **** 
  33:../src/main.c ****     	xprev = x;
 780              		.loc 1 33 0
 781 00c8 3B68     		ldr	r3, [r7, #0]	@ float
 782 00ca BB61     		str	r3, [r7, #24]	@ float
  34:../src/main.c ****     	change = -lambda*fp;
 783              		.loc 1 34 0
 784 00cc 7B6A     		ldr	r3, [r7, #36]
 785 00ce 83F00043 		eor	r3, r3, #-2147483648
 786 00d2 7A69     		ldr	r2, [r7, #20]	@ float
 787 00d4 1846     		mov	r0, r3
 788 00d6 1146     		mov	r1, r2
 789 00d8 FFF7FEFF 		bl	__aeabi_fmul
 790 00dc 0346     		mov	r3, r0
 791 00de 3B62     		str	r3, [r7, #32]	@ float
  35:../src/main.c ****     	x += change;
 792              		.loc 1 35 0
 793 00e0 3B68     		ldr	r3, [r7, #0]	@ float
 794 00e2 3A6A     		ldr	r2, [r7, #32]	@ float
 795 00e4 1846     		mov	r0, r3
 796 00e6 1146     		mov	r1, r2
 797 00e8 FFF7FEFF 		bl	__aeabi_fadd
 798 00ec 0346     		mov	r3, r0
 799 00ee 3B60     		str	r3, [r7, #0]	@ float
  36:../src/main.c **** 
  37:../src/main.c ****     	printf("x: %f, fp: %f, change: %f\n", x, fp, change);
 800              		.loc 1 37 0
 801 00f0 3B68     		ldr	r3, [r7, #0]	@ float
 802 00f2 1846     		mov	r0, r3
 803 00f4 FFF7FEFF 		bl	__aeabi_f2d
 804 00f8 8046     		mov	r8, r0
 805 00fa 8946     		mov	r9, r1
 806 00fc 7869     		ldr	r0, [r7, #20]	@ float
 807 00fe FFF7FEFF 		bl	__aeabi_f2d
 808 0102 0446     		mov	r4, r0
 809 0104 0D46     		mov	r5, r1
 810 0106 386A     		ldr	r0, [r7, #32]	@ float
 811 0108 FFF7FEFF 		bl	__aeabi_f2d
 812 010c 0246     		mov	r2, r0
 813 010e 0B46     		mov	r3, r1
 814 0110 CDE90045 		strd	r4, [sp]
 815 0114 CDE90223 		strd	r2, [sp, #8]
 816 0118 40F20000 		movw	r0, #:lower16:.LC5
 817 011c C0F20000 		movt	r0, #:upper16:.LC5
 818 0120 4246     		mov	r2, r8
 819 0122 4B46     		mov	r3, r9
 820 0124 FFF7FEFF 		bl	printf
  38:../src/main.c ****     	if (x==xprev) break;
 821              		.loc 1 38 0
 822 0128 3B68     		ldr	r3, [r7, #0]	@ float
 823 012a 1846     		mov	r0, r3
 824 012c B969     		ldr	r1, [r7, #24]	@ float
 825 012e FFF7FEFF 		bl	__aeabi_fcmpeq
 826 0132 0346     		mov	r3, r0
 827 0134 002B     		cmp	r3, #0
 828 0136 AFD0     		beq	.L3
 829              	.L2:
  39:../src/main.c ****     }
  40:../src/main.c **** 
  41:../src/main.c ****     // Enter an infinite loop, just incrementing a counter
  42:../src/main.c **** 	// This is for convenience to allow registers, variables and memory locations to be inspected at t
  43:../src/main.c **** 	volatile static int loop = 0;
  44:../src/main.c **** 	while (1) {
  45:../src/main.c **** 		loop++;
 830              		.loc 1 45 0
 831 0138 40F20003 		movw	r3, #:lower16:loop.1116
 832 013c C0F20003 		movt	r3, #:upper16:loop.1116
 833 0140 1B68     		ldr	r3, [r3, #0]
 834 0142 03F10102 		add	r2, r3, #1
 835 0146 40F20003 		movw	r3, #:lower16:loop.1116
 836 014a C0F20003 		movt	r3, #:upper16:loop.1116
 837 014e 1A60     		str	r2, [r3, #0]
 838 0150 F2E7     		b	.L2
 839              	.L6:
 840 0152 00BF     		.align	2
 841              	.L5:
 842 0154 CDCC4C3E 		.word	1045220557
 843              	.LFE2:
 896              	.Letext0:
DEFINED SYMBOLS
                            *ABS*:00000000 main.c
C:\Users\ELETCK~1.CKT\AppData\Local\Temp\ccX1xYJZ.s:26     .debug_macinfo:00000000 $d
C:\Users\ELETCK~1.CKT\AppData\Local\Temp\ccX1xYJZ.s:655    .bss:00000000 $d
C:\Users\ELETCK~1.CKT\AppData\Local\Temp\ccX1xYJZ.s:656    .bss:00000000 loop.1116
C:\Users\ELETCK~1.CKT\AppData\Local\Temp\ccX1xYJZ.s:659    .rodata:00000000 $d
C:\Users\ELETCK~1.CKT\AppData\Local\Temp\ccX1xYJZ.s:660    .rodata:00000000 .LC0
C:\Users\ELETCK~1.CKT\AppData\Local\Temp\ccX1xYJZ.s:664    .rodata:00000038 .LC1
C:\Users\ELETCK~1.CKT\AppData\Local\Temp\ccX1xYJZ.s:667    .rodata:0000003c .LC2
C:\Users\ELETCK~1.CKT\AppData\Local\Temp\ccX1xYJZ.s:673    .rodata:00000058 .LC3
C:\Users\ELETCK~1.CKT\AppData\Local\Temp\ccX1xYJZ.s:676    .rodata:00000068 .LC4
C:\Users\ELETCK~1.CKT\AppData\Local\Temp\ccX1xYJZ.s:681    .rodata:00000088 .LC5
C:\Users\ELETCK~1.CKT\AppData\Local\Temp\ccX1xYJZ.s:685    .text.main:00000000 $t
C:\Users\ELETCK~1.CKT\AppData\Local\Temp\ccX1xYJZ.s:690    .text.main:00000000 main
C:\Users\ELETCK~1.CKT\AppData\Local\Temp\ccX1xYJZ.s:842    .text.main:00000154 $d
C:\Users\ELETCK~1.CKT\AppData\Local\Temp\ccX1xYJZ.s:900    .debug_loc:00000000 $d

UNDEFINED SYMBOLS
__aeabi_f2iz
__aeabi_i2f
__aeabi_f2d
__aeabi_fmul
__aeabi_fadd
__aeabi_fcmpeq
printf
scanf
optimize
