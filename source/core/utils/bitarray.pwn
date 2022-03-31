#if defined _utils_bitarray_ || defined _INC_y_bit
    #endinput
#endif
#define _utils_bitarray_


// Standalone y_bit
// https://github.com/pawn-lang/YSI-Includes/blob/e15498f744548450f170d5f330eb26359f163a79/YSI_Data/y_bit/y_bit_impl.inc

#define BitArray:%1<%2> Bit:%1[%2]

#if cellbits == 32
    #define CELLSHIFT (5)
#elseif cellbits == 64
    #define CELLSHIFT (6)
#elseif cellbits == 16
    #define CELLSHIFT (4)
#else
    #error Unknown cell size
#endif

#define Bit_Bits(%1) (((%1) + cellbits - 1) / cellbits)

#define Bit_Slot(%1) ((_:%1) >>> CELLSHIFT)

#define Bit_Mask(%1) (Bit:(1 << ((_:1) & cellbits - 1)))

#define Bit_GetBit(%1,%2) (%1[(%2) >>> CELLSHIFT] >>> Bit:((%2) & cellbits - 1) & Bit:1)

#define Bit_Get(%1,%2) bool:Bit_GetBit(%1,_:%2)

#define Bit_Let(%1,%2) (%1[(%2) >>> CELLSHIFT] |= Bit:(1 << ((%2) & cellbits - 1)))
#define Bit_Vet(%1,%2) (%1[(%2) >>> CELLSHIFT] &= Bit:~(1 << ((%2) & cellbits - 1)))

#define Bit_Toggle(%1,%2) (%1[(%2)>>>CELLSHIFT]^=Bit:(1<<((%2)&cellbits-1)))

stock Bit_Set(BitArray:array<>, slot, bool:set)
{
    if(set)
        Bit_Let(array, slot);
    else
        Bit_Vet(array, slot);
}

#define Bit_FastSet(%0,%1,%2) ((%2) ? (Bit_Let(%0,(%1))) : (Bit_Vet(%0,(%1))))

stock Bit_SetAll(BitArray:array<>, bool:set, size = sizeof(array))
{
    memset(_:array, set ? 0xFFFFFFFF : 0, size);
}

stock Bit_Display(const BitArray:array<>, size = sizeof (array))
{
	new
		ret[144],
		val = 0;
	while (size--)
	{
		val = _:array[size];
		format(ret, sizeof (ret), "%s%016b%016b", ret, val >>> 16, val & 0xFFFF);
	}
	//P:7("Bit_Display called: %s, %i", ret, size);
	return ret;
}

#define bits<%0> Bit_Bits(%0)

#undef BitArray
#define BitArray:%0<%1> Bit:%0[bits<%1>]
