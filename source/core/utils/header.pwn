#if defined _UTILS_HEADER_
	#endinput
#endif
#define _UTILS_HEADER_

const cellbytes = (cellbits / charbits);

const HYAXE_UNSAFE_HUGE_LENGTH = 2048;
new HYAXE_UNSAFE_HUGE_STRING[HYAXE_UNSAFE_HUGE_LENGTH];

/*  
** %0 = Array to fill
** %1 = Value to fill array with (must be constant)
** %2 = Amount of cells to fill in array
** Indexing the array is required per https://github.com/pawn-lang/compiler/issues/695
*/
#define memset_single(%0,%1,%2) __emit(addr.u.alt %0[0], const.pri %1, fill (%2 * cellbytes))

#if !NDEBUG
	#define DEBUG_PRINT(%1) printf("[dbg] "%1)
#else
	#define DEBUG_PRINT(%1);
#endif

#define Performance_IsFine(%0) (GetPlayerPing(%0) <= 300 && NetStats_PacketLossPercent(%0) <= 4.5 && GetServerTickRate() >= 100)

#if !defined GLOBAL_TAG_TYPES
	#if defined CUSTOM_TAG_TYPES
		#define GLOBAL_TAG_TYPES {_,Bit,Text,File,Float,Text3D,CUSTOM_TAG_TYPES}
	#else
		#define GLOBAL_TAG_TYPES {_,Bit,Text,File,Float,Text3D}
	#endif
#endif

#define _HexToRGBA(%1,%2,%3,%4) (((%4) & 0xFF) | (((%3) & 0xFF) << 8) | (((%2) & 0xFF) << 16) | ((%1) << 24))
#define _RGBAToHex(%0,%1,%2,%3,%4) (((%1) = ((%0) >>> 24)),((%2) = (((%0) >>> 16) & 0xFF)),((%3) = (((%0) >>> 8) & 0xFF)),((%4) = ((%0) & 0xFF)))

#define IS_NAN(%0) (_:((Float:0x7FFFFFFF) & (%0)) > (0x7F800000))
#define IsNaN(%0) IS_NAN(%0)

#define MAKE_CELL(%0,%1,%2,%3) (((%0) << 24) | ((%1) << 16) | ((%2) << 8) | %3)

#define M_PI 3.141592

#include "core/utils/sounds.pwn"
#include "core/utils/zones.pwn"
#include "core/utils/calendar.pwn"