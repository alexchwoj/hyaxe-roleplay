#if defined _admin_callbacks_
    #endinput
#endif
#define _admin_callbacks_

#include <YSI_Coding/y_hooks>

hook OnPlayerText(playerid, text[])
{
    if (text[0] == '#')
    {
        if (Player_AdminLevel(playerid) > RANK_LEVEL_USER && !Bit_Get(Player_Config(playerid), CONFIG_DISABLE_ADMIN_MESSAGES))
        {
            format(YSI_UNSAFE_HUGE_STRING, YSI_UNSAFE_HUGE_LENGTH, "[Admin] › {DADADA}%s %s (%d): %s", Player_GetRankName(playerid), Player_RPName(playerid), playerid, text[1]);
            
            new start = 0, end, next, next_color = 0x415BA2FF, bool:hyphen = false;
            new const bool:split = IterativeColouredTextSplitter(YSI_UNSAFE_HUGE_STRING, 144, start, end, next, hyphen, next_color, false);
            
            if (!split)
            {
                Admins_SendMessage(RANK_LEVEL_HELPER, 0x415BA2FF, YSI_UNSAFE_HUGE_STRING);
            }
            else
            {
                new message[144];
                strmid(message, YSI_UNSAFE_HUGE_STRING, start, end);
                Admins_SendMessage(RANK_LEVEL_HELPER, 0x415BA2FF, message);   

                format(message, sizeof(message), "%s", YSI_UNSAFE_HUGE_STRING[next]);
                if ((next_color & 0xFF000000) == 0)
                    next_color = (next_color << 8) | 0xFF;

                Admins_SendMessage(RANK_LEVEL_HELPER, next_color, message);     
            }

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