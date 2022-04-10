#if defined _admin_callbacks_
    #endinput
#endif
#define _admin_callbacks_

public OnPlayerText(playerid, text[])
{
    if(text[0] == '#')
    {
        if(Player_AdminLevel(playerid) > RANK_LEVEL_USER && !Bit_Get(Player_Config(playerid), CONFIG_DISABLE_ADMIN_MESSAGES))
        {
            new messages[2][144];
            format(HYAXE_UNSAFE_HUGE_STRING, HYAXE_UNSAFE_HUGE_LENGTH, "[Admin] › {DADADA}%s %s: %s", Player_GetRankName(playerid), Player_RPName(playerid), text[1]);
            for(new i, j = SplitChatMessageInLines(HYAXE_UNSAFE_HUGE_STRING, messages); i < j; ++i)
                Admins_SendMessage(RANK_LEVEL_HELPER, 0x415BA2FF, messages[i]);

            return 0;
        }
    }

    #if defined ADMIN_OnPlayerText
        return ADMIN_OnPlayerText(playerid, text);
    #else
        return 0;
    #endif
}

#if defined _ALS_OnPlayerText
    #undef OnPlayerText
#else
    #define _ALS_OnPlayerText
#endif
#define OnPlayerText ADMIN_OnPlayerText
#if defined ADMIN_OnPlayerText
    forward ADMIN_OnPlayerText(playerid, text[]);
#endif
