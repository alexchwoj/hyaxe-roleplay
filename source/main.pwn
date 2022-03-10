#pragma option -;+
#pragma option -(+
#pragma semicolon 1
#pragma warning disable 239
#pragma warning disable 214

#define NDEBUG 0

#if NDEBUG
	#pragma option -d0
	#pragma option -O1
#else
	#pragma option -d3
#endif

#define FOREACH_NO_BOTS

public const __HYAXE__ = 1;

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
#include <amx/amx_header>

/*
		YSI is pozzed
							*/

// Plugin
////////////
#include "core/interop/header.pwn"

// Fixes
///////////
#include "core/fixes/textdraws.pwn"
#include "core/fixes/player.pwn"

// Utils
///////////
#include "core/utils/iterators.pwn"

// Headers
/////////////
#include "core/utils/header.pwn"
#include "core/database/header.pwn"
#include "core/config/header.pwn"
#include "core/notification/header.pwn"
#include "core/dialogs/header.pwn"
#include "core/commands/header.pwn"
#include "core/key/header.pwn"
#include "server/textdraws/header.pwn"
#include "server/vehicles/header.pwn"
#include "server/enter_exits/header.pwn"
#include "server/actors/header.pwn"
#include "server/atm/header.pwn"
#include "server/jobs/header.pwn"
#include "server/jobs/gunsmaker/header.pwn"
#include "player/account/header.pwn"
#include "player/admin/header.pwn"
#include "player/auth/header.pwn"
#include "player/needs/header.pwn"
#include "player/chat/header.pwn"
#include "player/weapons/header.pwn"
#include "player/keygame/header.pwn"

// Functions
///////////////
#include "core/utils/functions.pwn"
#include "core/notification/functions.pwn"
#include "core/dialogs/functions.pwn"
#include "core/commands/functions.pwn"
#include "core/key/functions.pwn"
#include "server/anticheat/functions.pwn"
#include "server/vehicles/functions.pwn"
#include "server/enter_exits/functions.pwn"
#include "server/actors/functions.pwn"
#include "server/atm/functions.pwn"
#include "server/jobs/functions.pwn"
#include "player/account/functions.pwn"
#include "player/admin/functions.pwn"
#include "player/needs/functions.pwn"
#include "player/chat/functions.pwn"
#include "player/weapons/functions.pwn"
#include "player/keygame/functions.pwn"

// Callbacks
///////////////
#include "core/database/callbacks.pwn"
#include "core/config/callbacks.pwn"
#include "core/notification/callbacks.pwn"
#include "core/dialogs/callbacks.pwn"
#include "core/commands/callbacks.pwn"
#include "core/key/callbacks.pwn"
#include "server/textdraws/callbacks.pwn"
#include "server/vehicles/callbacks.pwn"
#include "server/enter_exits/callbacks.pwn"
#include "server/stores/pizza/callbacks.pwn"
#include "server/actors/callbacks.pwn"
#include "server/jobs/gunsmaker/callbacks.pwn"
#include "server/atm/callbacks.pwn"
#include "player/account/callbacks.pwn"
#include "player/auth/callbacks.pwn"
#include "player/needs/callbacks.pwn"
#include "player/chat/callbacks.pwn"
#include "player/keygame/callbacks.pwn"

#include "server/anticheat/callbacks.pwn"

// Prevents runtime error 20 (invalid index)
main() { return 0; }
