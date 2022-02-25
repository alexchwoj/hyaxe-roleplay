#pragma option -;+
#pragma option -(+
#pragma semicolon 1
#pragma warning disable 239

#define NDEBUG 0

#if NDEBUG
	#pragma option -d0
	#pragma option -O1
#else
	#pragma option -d3
#endif

#define FOREACH_NO_BOTS

// Daniel-Cortez's Anti-DeAMX
////////////////////////////////
@__beware__black_people__();
@__beware__black_people__()
{
	#emit    stack    0x7FFFFFFF
	#emit    inc.s    cellmax

	static const ___[][] = { "hi", "i hate balck people" };

	#emit    retn
	#emit    load.s.pri    ___
	#emit    proc
	#emit    proc
	#emit    fill    cellmax
	#emit    proc
	#emit    stack    1
	#emit    stor.alt    ___
	#emit    strb.i    2
	#emit    switch    0
	#emit    retn
L1:
	#emit    jump    L1
	#emit    zero    cellmin
}

#include <a_samp>

#undef MAX_PLAYERS
#define MAX_PLAYERS 422

#include <jit>
#include <streamer>
#include <YSF>
#include <sscanf2>
#include <Pawn.CMD>
#include <Pawn.Regex>
#include <Pawn.RakNet>
#include <a_mysql>
#include <foreach>

// Fixes
///////////
#include "core/fixes/textdraws.pwn"

// Headers
/////////////
#include "core/utils/header.pwn"
#include "core/database/header.pwn"
#include "core/config/header.pwn"

// Functions
///////////////
#include "core/utils/functions.pwn"

// Callbacks
///////////////
#include "core/database/callbacks.pwn"
#include "core/config/callbacks.pwn"

// Prevents runtime error 20 (invalid index)
main() { return 0; }
