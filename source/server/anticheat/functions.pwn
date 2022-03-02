#if defined _anticheat_functions_
    #endinput
#endif
#define _anticheat_functions_

stock ac_SetPlayerChatBubble(playerid, const text[], color, Float:drawdistance, expiretime)
{
    if(!IsPlayerConnected(playerid))
        return 0;

    new bubble_length = strlen(text);
    if(bubble_length >= 144)
        return 0;

    new BitStream:bs = BS_New();
    BS_WriteValue(bs,
        PR_UINT16, playerid,
        PR_UINT32, color,
        PR_FLOAT, drawdistance,
        PR_UINT32, expiretime,
        PR_UINT8, bubble_length,
        PR_STRING, text
    );

    foreach(new i : StreamedPlayer[playerid])
    {
        PR_SendRPC(bs, i, 59, PR_HIGH_PRIORITY, PR_RELIABLE);
    }

    BS_Delete(bs);

    return 1;
}

#if !defined _ALS_SetPlayerChatBubble
    #define _ALS_SetPlayerChatBubble
#endif
#define SetPlayerChatBubble ac_SetPlayerChatBubble
