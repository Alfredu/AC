all: hecho asm asmXMM asmXMMAL asmXMMDual
hecho:
	gcc Transformar.c tiempo.c Procesar.c -m32 -o transformC
asm:
	gcc Transformar.c tiempo.c Procesar_asm.s -m32 -o transformASM
asmXMM:
	gcc Transformar.c tiempo.c Procesar_unal.s -m32 -o transformASM_xmm
asmXMMAL:
	gcc Transformar.c tiempo.c Procesar_align.s -m32 -o transformAligned
asmXMMDual:
	gcc Transformar.c tiempo.c Procesar_dual.s -m32 -o transformDual