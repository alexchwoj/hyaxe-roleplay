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

/*  
** %0 = Array to fill
** %1 = Value to fill array with (must be constant)
** %2 = Amount of cells to fill in array
** Indexing the array is required per https://github.com/pawn-lang/compiler/issues/695
*/
#define memset_single(%0,%1,%2) __emit(addr.u.alt %0[0], const.pri %1, fill (%2 * cellbytes))

#if !NDEBUG
	#define DEBUG_PRINT(%1) printf(%1)
#else
	#define DEBUG_PRINT(%1);
#endif

#define Performance_IsFine(%0) (GetPlayerPing(%0) <= 300 && NetStats_PacketLossPercent(%0) <= 4.5 && GetServerTickRate() >= 200)

#if !defined GLOBAL_TAG_TYPES
	#if defined CUSTOM_TAG_TYPES
		#define GLOBAL_TAG_TYPES {_,Bit,Text,File,Float,Text3D,CUSTOM_TAG_TYPES}
	#else
		#define GLOBAL_TAG_TYPES {_,Bit,Text,File,Float,Text3D}
	#endif
#endif

#if !defined minrand
	#define minrand(%0,%1) (random((%1) - (%0)) + (%0))
#endif

#define IS_NAN(%0) (_:((Float:0x7FFFFFFF) & (%0)) > (0x7F800000))
#define IsNaN(%0) IS_NAN(%0)

#include "core/utils/bitarray.pwn"
#include "core/utils/cells.pwn"
#include "core/utils/sounds.pwn"