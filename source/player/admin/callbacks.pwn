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
