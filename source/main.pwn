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

#define FOREACH_I_Player 1
#define FOREACH_I_Bot 0
#define FOREACH_I_Character 0
#define FOREACH_I_Vehicle 0
#define FOREACH_I_Actor 0

#define PP_SYNTAX_ON_INIT
#define PP_SYNTAX_ON_EXIT
#define PP_SYNTAX_FOR_LIST
#define PP_SYNTAX_GENERIC
#define PP_SYNTAX_FOR_MAP
#define PP_SYNTAX_@

#define FCNPC_DISABLE_VERSION_CHECK

public const __HYAXE__ = 1;

// Daniel-Cortez's Anti-DeAMX
////////////////////////////////
__beware__black_people__();
__beware__black_people__()
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

const __dada = __addressof(__beware__black_people__);
#pragma unused __dada

#include <a_samp>

#undef MAX_PLAYERS
#define MAX_PLAYERS 500
const HYAXE_MAX_NPCS = 100;

#include <jit>
#include <streamer>
#include <YSF>
#include <sscanf2>
#include <Pawn.CMD>
#include <Pawn.Regex>
#include <Pawn.RakNet>
#include <PawnPlus>
#include <a_mysql>
#include <colandreas>
#include <foreach>
#include <md-sort>
#include <amx/frame_info>
#include <amx/amx_memory>
#include <FCNPC>

/*
		YSI is pozzed
							*/

// Plugin
////////////
#include "core/interop/header.pwn"

// Utils
///////////
#include "core/utils/header.pwn"

// Fixes
///////////
#include "core/fixes/textdraws.pwn"
#include "core/fixes/player.pwn"
#include "core/fixes/bots.pwn"

// Headers
/////////////
#include "core/utils/iterators.pwn"
#include "core/database/header.pwn"
#include "core/config/header.pwn"
#include "core/notification/header.pwn"
#include "core/dialogs/header.pwn"
#include "core/commands/header.pwn"
#include "core/key/header.pwn"
#include "server/textdraws/header.pwn"
#include "server/vehicles/header.pwn"
#include "server/enter_exits/header.pwn"
#include "server/stores/header.pwn"
#include "server/actors/header.pwn"
#include "server/atm/header.pwn"
#include "server/jobs/header.pwn"
#include "server/jobs/gunsmaker/header.pwn"
#include "server/jobs/lawnmower/header.pwn"
#include "server/hospital/header.pwn"
#include "server/hookers/header.pwn"
#include "player/account/header.pwn"
#include "player/damage/header.pwn"
#include "player/admin/header.pwn"
#include "player/auth/header.pwn"
#include "player/needs/header.pwn"
#include "player/chat/header.pwn"
#include "player/weapons/header.pwn"
#include "player/keygame/header.pwn"
#include "player/death/header.pwn"

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
#include "server/stores/functions.pwn"
#include "server/actors/functions.pwn"
#include "server/atm/functions.pwn"
#include "server/jobs/functions.pwn"
#include "server/hospital/functions.pwn"
#include "player/account/functions.pwn"
#include "player/damage/functions.pwn"
#include "player/admin/functions.pwn"
#include "player/needs/functions.pwn"
#include "player/chat/functions.pwn"
#include "player/weapons/functions.pwn"
#include "player/keygame/functions.pwn"
#include "player/death/functions.pwn"

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
#include "server/stores/callbacks.pwn"
#include "server/stores/pizza/callbacks.pwn"
#include "server/actors/callbacks.pwn"
#include "server/jobs/callbacks.pwn"
#include "server/hospital/callbacks.pwn"
#include "server/jobs/gunsmaker/callbacks.pwn"
#include "server/jobs/lawnmower/callbacks.pwn"
#include "server/atm/callbacks.pwn"
#include "server/hookers/callbacks.pwn"
#include "player/account/callbacks.pwn"
#include "player/damage/callbacks.pwn"
#include "player/auth/callbacks.pwn"
#include "player/needs/callbacks.pwn"
#include "player/chat/callbacks.pwn"
#include "player/keygame/callbacks.pwn"
#include "player/death/callbacks.pwn"

#include "server/anticheat/callbacks.pwn"

// Prevents runtime error 20 (invalid index)
main() { return 0; }
