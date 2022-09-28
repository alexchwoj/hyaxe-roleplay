/*
.......................................................................
.   o   \ o /  _ o        __|    \ /     |__         o _  \ o /   o   .
.  /|\    |     /\   __\o   \o    |    o/     o/__   /\     |    /|\  .
.  / \   / \   | \  /) |    ( \  /o\  / )    |   (\  / |   / \   / \  .
.       .......................................................       .
. \ o / .                                                     . \ o / .
.   |   .                                                     .   |   .
.  / \  .     **********THE BEST RAKSAMP EVER************     .  / \  .
.       .                                                     .       .
.  _ o  .     		   __    _____ _____ _____                .  _ o  .
.   /\  .     		  |  |  |     |  _  |     |               .   /\  .
.  | \  .     		  |  |__| | | |     |  |  |               .  | \  .
.       .     		  |_____|_|_|_|__|__|_____|               .       .
.       .      _____ __ __ _____ _____ _____ _____ _____      .       .
.  __\o .     |   __|  |  |_   _| __  |   __|     |   __|     .  __\o .
. /) |  .     |   __|-   -| | | |    -|   __| | | |   __|     . /) |  .
.       .     |_____|__|__| |_| |__|__|_____|_|_|_|_____|     .       .
. __|   .                                                     . __|   .
.   \o  .     >>>>>>>>>>>>>>>-- CREDITS --<<<<<<<<<<<<<<<     .    \o .
.   ( \ .                                                     .   ( \ .
.       .      .P3TI.     .TYT.      .FYP.        .OPCODE.    .       .
.  \ /  .               .HANDZ.       .BRAINZ.                .  \ /  .
.   |   .                                                     .   |   .
.  /o\  .     .-.            .-.                              .  /o\  .
.       .   .-| |-.        .-| |-.          _---~~(~~-_.      .       .
.   |__ .   | | | |  THX   | | | |        _{  KK    )   )     .   |__ .
. o/    . .-| | | |        | | | |-.    ,   ) -~~- ( ,-' )_   . o/    .
./ )    . | | | | |        | | | | |   (  `-,_..`., )-- '_,)  ./ )    .
.       . | | | | |-.    .-| | |*| |  (_-  _  ~_-~~~~`,  ,' ) .       .
.       . | '     | |    | |     ` |    `~ -^(    __;-,((())) .       .
. o/__  . |       | |    | |       |          ~~~~ {_ -_(())  . o/__  .
.  | (\ . |         |    |         |     THX        `\  }     . |  (\ .
.       . \         /    \         /                 `\  }    .       .
.  o _  .  |       |     |       |                            .  o _  .
.  /\   .  |       |     |       |                            .  /\   .
.  / |  .      +----------------------------------+           .  / |  .
.       .      |     MANY THANKS TO OUR HANDS     |           .       .
. \ o / .      | AND BRAINS TO MAKE THIS POSSIBLE |           . \ o / .
.   |   .      +----------------------------------+           .   |   .
.  / \  .                                                     .  / \  .
.       .......................................................       .
.   o   \ o /  _ o        __|    \ /     |__         o _  \ o /   o   .
.  /|\    |     /\   __\o   \o    |    o/     o/__   /\     |    /|\  .
.  / \   / \   | \  /) |    ( \  /o\  / )    |   (\  / |   / \   / \  .
.......................................................................
*/

#pragma option -;+
#pragma option -(+
#pragma semicolon 1
#pragma warning disable 239
#pragma warning disable 214

#define SERVER_VERSION "v1.0.0-alpha"

#define NDEBUG 0

#if NDEBUG
	#pragma option -d0
	#pragma option -O1
#else
	#pragma option -d3
	#include <crashdetect>
#endif

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
#include <a_mysql>
#include <colandreas>
#include <FCNPC>
//#include <foreach>
#include <md-sort>

/*
		YSI is pozzed
							*/
#define YSI_NO_KEYWORD_List
#define YSI_NO_HEAP_MALLOC
#define YSI_NO_ANDROID_CHECK
#define YSI_NO_VERSION_CHECK
#define FOREACH_NO_BOTS
#define FOREACH_NO_LOCALS
#define FOREACH_NO_VEHICLES
#define FOREACH_NO_ACTORS

#include <YSI_Core/y_cell>
#include <YSI_Coding/y_hooks>
#include <YSI_Coding/y_inline>
#include <YSI_Coding/y_va>
#include <YSI_Data/y_bit>
#include <YSI_Data/y_iterate>
#include <YSI_Extra/y_inline_mysql>
#include <YSI_Extra/y_inline_timers>
#include <YSI_Storage/y_amx>
#include <YSI_Visual/y_dialog>
#include <amx/amx_header>

// Plugin
////////////
#include "core/interop/header.pwn"

// Utils
///////////
#include "core/utils/header.pwn"

// Fixes
///////////
#include "core/fixes/streamer.pwn"
#include "core/fixes/textdraws.pwn"
#include "core/fixes/player.pwn"

// Headers
/////////////
#include "core/utils/iterators.pwn"
#include "core/async/header.pwn"
#include "core/database/header.pwn"
#include "core/config/header.pwn"
#include "core/animations/header.pwn"
#include "core/notification/header.pwn"
#include "core/menu/header.pwn"
#include "core/dialogs/header.pwn"
#include "core/commands/header.pwn"
#include "core/key/header.pwn"
#include "server/anticheat/header.pwn"
#include "server/textdraws/header.pwn"
#include "server/vehicles/header.pwn"
#include "server/enter_exits/header.pwn"
#include "server/stores/header.pwn"
#include "server/stores/clothing/header.pwn"
#include "server/stores/dealership/header.pwn"
#include "server/actors/header.pwn"
#include "server/atm/header.pwn"
#include "server/jobs/header.pwn"
#include "server/jobs/gunsmaker/header.pwn"
#include "server/jobs/lawnmower/header.pwn"
#include "server/jobs/trucker/header.pwn"
#include "server/hospital/header.pwn"
#include "server/hookers/header.pwn"
#include "server/territories/header.pwn"
#include "server/gangs/header.pwn"
#include "server/gangs/events/header.pwn"
#include "server/fuel_station/header.pwn"
#include "server/car_rental/header.pwn"
#include "server/weather/header.pwn"
#include "server/tuning/header.pwn"
#include "player/account/header.pwn"
#include "player/config/header.pwn"
#include "player/damage/header.pwn"
#include "player/admin/header.pwn"
#include "player/leveling/header.pwn"
#include "player/auth/header.pwn"
#include "player/inventory/header.pwn"
#include "player/needs/header.pwn"
#include "player/chat/header.pwn"
#include "player/weapons/header.pwn"
#include "player/keygame/header.pwn"
#include "player/death/header.pwn"
#include "player/police/header.pwn"
#include "player/gps/header.pwn"
#include "player/phone/header.pwn"

// Functions
///////////////
#include "core/utils/functions.pwn"
#include "core/animations/functions.pwn"
#include "core/notification/functions.pwn"
#include "core/menu/functions.pwn"
#include "core/dialogs/functions.pwn"
#include "core/commands/functions.pwn"
#include "core/key/functions.pwn"
#include "server/anticheat/functions.pwn"
#include "server/vehicles/functions.pwn"
#include "server/enter_exits/functions.pwn"
#include "server/stores/functions.pwn"
#include "server/stores/clothing/functions.pwn"
#include "server/actors/functions.pwn"
#include "server/atm/functions.pwn"
#include "server/jobs/functions.pwn"
#include "server/jobs/gunsmaker/functions.pwn"
#include "server/hospital/functions.pwn"
#include "server/hookers/functions.pwn"
#include "server/gangs/functions.pwn"
#include "server/gangs/events/functions.pwn"
#include "server/territories/functions.pwn"
#include "server/fuel_station/functions.pwn"
#include "server/weather/functions.pwn"
#include "server/tuning/functions.pwn"
#include "player/account/functions.pwn"
#include "player/config/functions.pwn"
#include "player/damage/functions.pwn"
#include "player/inventory/functions.pwn"
#include "player/admin/functions.pwn"
#include "player/leveling/functions.pwn"
#include "player/needs/functions.pwn"
#include "player/chat/functions.pwn"
#include "player/weapons/functions.pwn"
#include "player/keygame/functions.pwn"
#include "player/death/functions.pwn"
#include "player/police/functions.pwn"
#include "player/animation/functions.pwn"
#include "player/gps/functions.pwn"
#include "player/phone/functions.pwn"

// Callbacks
///////////////
#include "core/database/callbacks.pwn"
#include "core/config/callbacks.pwn"
#include "core/animations/callbacks.pwn"
#include "core/notification/callbacks.pwn"
#include "core/menu/callbacks.pwn"
#include "core/dialogs/callbacks.pwn"
#include "core/commands/callbacks.pwn"
#include "core/key/callbacks.pwn"
#include "server/anticheat/callbacks.pwn"
#include "server/textdraws/callbacks.pwn"
#include "server/vehicles/callbacks.pwn"
#include "server/enter_exits/callbacks.pwn"
#include "server/stores/callbacks.pwn"
#include "server/stores/pizza/callbacks.pwn"
#include "server/stores/clothing/callbacks.pwn"
#include "server/stores/dealership/callbacks.pwn"
#include "server/stores/convenience/callbacks.pwn"
#include "server/actors/callbacks.pwn"
#include "server/jobs/callbacks.pwn"
#include "server/hospital/callbacks.pwn"
#include "server/jobs/gunsmaker/callbacks.pwn"
#include "server/jobs/lawnmower/callbacks.pwn"
#include "server/jobs/trucker/callbacks.pwn"
#include "server/jobs/fisherman/callbacks.pwn"
#include "server/atm/callbacks.pwn"
#include "server/hookers/callbacks.pwn"
#include "server/gangs/callbacks.pwn"
#include "server/gangs/events/callbacks.pwn"
#include "server/territories/callbacks.pwn"
#include "server/black_market/callbacks.pwn"
#include "server/fuel_station/callbacks.pwn"
#include "server/car_rental/callbacks.pwn"
#include "server/weather/callbacks.pwn"
#include "server/tuning/callbacks.pwn"
#include "player/account/callbacks.pwn"
#include "player/damage/callbacks.pwn"
#include "player/leveling/callbacks.pwn"
#include "player/auth/callbacks.pwn"
#include "player/inventory/callbacks.pwn"
#include "player/inventory/items/callbacks.pwn"
#include "player/admin/callbacks.pwn"
#include "player/needs/callbacks.pwn"
#include "player/chat/callbacks.pwn"
#include "player/keygame/callbacks.pwn"
#include "player/death/callbacks.pwn"
#include "player/police/callbacks.pwn"
#include "player/weapons/callbacks.pwn"
#include "player/gps/callbacks.pwn"
#include "player/phone/callbacks.pwn"
//#include "server/debug/callbacks.pwn"

// Anticheat
///////////////
#include "server/anticheat/detections/speedhack.pwn"
#include "server/anticheat/detections/fly.pwn"
#include "server/anticheat/detections/weapon.pwn"
#include "server/anticheat/detections/repaircar.pwn"
#include "server/anticheat/detections/money.pwn"
#include "server/anticheat/detections/slapper.pwn"
#include "server/anticheat/detections/teleport.pwn"
#include "server/anticheat/detections/invisible.pwn"
#include "server/anticheat/detections/invalid_sync.pwn"
#include "server/anticheat/detections/carjack.pwn"
#include "server/anticheat/detections/airbreak.pwn"

// Commands
//////////////
#include "server/anticheat/commands.pwn"
#include "player/chat/commands.pwn"
#include "player/needs/commands.pwn"
#include "player/admin/commands.pwn"
#include "player/police/commands.pwn"
#include "server/gangs/commands.pwn"

// Prevents runtime error 20 (invalid index)
main() { return 0; }

public OnJITCompile()
{
	print("[func] OnJITCompile()");
	return 1;
}

SSCANF:boolean(string[])
{
	if('0' <= string[0] <= '9')
	{
		return (string[0] == '1');
	}
	else if(!strcmp(string, "true", true)) return 1;
	else if(!strcmp(string, "false", true)) return 0;
	else if(!strcmp(string, "sí", true) || !strcmp(string, "si", true)) return 1;
	else if(!strcmp(string, "no", true)) return 0;

	return 0;
}