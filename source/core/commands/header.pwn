#if defined _commands_header_
    #endinput
#endif
#define _commands_header_

const HYAXE_MAX_COMMANDS = 100;
#define CMD_FLAG<%0> ((%0) << 24)

enum _:eCommandFlags(<<=1)
{
    CMD_HIDDEN = 1,
    CMD_NO_COOLDOWN,
    CMD_DONT_LOG_COMMAND,

    CMD_INVALID_FLAG
};

#assert CMD_INVALID_FLAG < 0b100000000000000000000000

enum eCommandStore 
{
    e_szCommandName[32],
    e_iCommandNameHash,
    e_szCommandDescription[50]
};

new g_rgeCommandStore[HYAXE_MAX_COMMANDS][eCommandStore];
new g_rgiPlayerCommandCooldown[MAX_PLAYERS];
new g_rgiPlayerCommandsDialog[MAX_PLAYERS][20] = { -1, ... };

#define command%4\32;%0(%1,%2,%3) \
    forward hy@cmd_%0();\
    public hy@cmd_%0() {\
        DEBUG_PRINT("[cmd] Registering command \"%s\"", #%0);\
        new id = Commands_GetFreeIndex();\
        strcpy(g_rgeCommandStore[id][e_szCommandName], #%0);\
        g_rgeCommandStore[id][e_iCommandNameHash] = _H<%0>;\
        strcpy(g_rgeCommandStore[id][e_szCommandDescription], %3);\
        return 1;\
    }\
    CMD:%0(%1,%2)
