#if defined _UTILS_HEADER_
	#endinput
#endif
#define _UTILS_HEADER_

const cellbytes = (cellbits / charbits);

const HYAXE_UNSAFE_HUGE_LENGTH = 1024;
new HYAXE_UNSAFE_HUGE_STRING[HYAXE_UNSAFE_HUGE_LENGTH];

#if !defined isnull
	#define isnull(%0) ((%0[(%0[0])=='\1'])=='\0')
#endif

#if !defined strcpy
	#define strcpy(%0,%1) strcat((%0[0] = '\0', %0), %1)
#endif

#if !defined IS_IN_RANGE
	#define IS_IN_RANGE(%0,%1,%2) (((%0)-((%1)+cellmin))<((%2)-((%1)+cellmin)))
#endif

#if !defined NOT_IN_RANGE
	#define NOT_IN_RANGE(%0,%1,%2) (((%0)-((%1)+cellmin))>=((%2)-((%1)+cellmin)))
#endif

#if !defined memset
	/*  
	** %0 = Array to fill
	** %1 = Value to fill array with (must be constant)
	** %2 = Amount of cells to fill in array
	** Indexing the array is required per https://github.com/pawn-lang/compiler/issues/695
	*/
	#define memset(%0,%1,%2) __emit(addr.u.alt %0[0], const.pri %1, fill (%2 * cellbytes))
#endif

#include "core/utils/bitarray.pwn"
