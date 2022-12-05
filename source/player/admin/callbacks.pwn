#if defined _admin_callbacks_
    #endinput
#endif
#define _admin_callbacks_

#include <YSI_Coding/y_hooks>

hook OnPlayerText(playerid, text[])
{
    if(text[0] == '#')
    {
        if(Player_AdminLevel(playerid) > RANK_LEVEL_USER && !Bit_Get(Player_Config(playerid), CONFIG_DISABLE_ADMIN_MESSAGES))
        {
            new messages[2][144];
            format(HYAXE_UNSAFE_HUGE_STRING, HYAXE_UNSAFE_HUGE_LENGTH, "[Admin] › {DADADA}%s %s (%d): %s", Player_GetRankName(playerid), Player_RPName(playerid), playerid, text[1]);
            for(new i, j = SplitChatMessageInLines(HYAXE_UNSAFE_HUGE_STRING, messages); i < j; ++i)
                Admins_SendMessage(RANK_LEVEL_HELPER, 0x415BA2FF, messages[i]);

            return ~0;
        }
    }

    return 0;
}

public OnPlayerDeath(playerid, killerid, reason)
{
    if (Bit_Get(Player_Flags(playerid), PFLAG_IN_GAME) && !Bit_Get(Player_Flags(playerid), PFLAG_IN_JAIL))
    {
        foreach(new i : Admin)
        {
            SendDeathMessageToPlayer(i, killerid, playerid, reason);
        }
    }

    #if defined ADMIN_OnPlayerDeath
        return ADMIN_OnPlayerDeath(playerid, killerid, reason);
    #else
        return 1;
    #endif
}

#if defined _ALS_OnPlayerDeath
    #undef OnPlayerDeath
#else
    #define _ALS_OnPlayerDeath
#endif
#define OnPlayerDeath ADMIN_OnPlayerDeath
#if defined ADMIN_OnPlayerDeath
    forward ADMIN_OnPlayerDeath(playerid, killerid, reason);
#endif