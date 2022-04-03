#if defined _anticheat_functions_
    #endinput
#endif
#define _anticheat_functions_

Anticheat_Trigger(playerid, eCheats:cheat)
{
    if(g_rgeDetectionData[cheat][e_ePunishmentType] == PUNISHMENT_KICK_ON_MAX_TRIGGERS || g_rgeDetectionData[cheat][e_ePunishmentType] == PUNISHMENT_BAN_ON_MAX_TRIGGERS)
    {
        if(g_rgeDetectionData[cheat][e_iMaxTriggers] > ++g_rgiAnticheatTriggers[playerid]{cheat})
        {
            return 1;
        }
    }

    switch(g_rgeDetectionData[cheat][e_ePunishmentType])
    {
        case PUNISHMENT_IGNORE:
            return 1;

        case PUNISHMENT_WARN_ADMINS:
        {
            format(HYAXE_UNSAFE_HUGE_STRING, HYAXE_UNSAFE_HUGE_LENGTH, "[AC] {DADADA}El jugador {415BA2}%s{DADADA} ({415BA2}%i{DADADA}) fue detectado por {415BA2}%s{DADADA}.", Player_RPName(playerid), playerid, g_rgeDetectionData[cheat][e_szDetectionName]);
            Admins_SendMessage(RANK_LEVEL_MODERATOR, 0x415BA2FF, HYAXE_UNSAFE_HUGE_STRING);
        }
        case PUNISHMENT_KICK, PUNISHMENT_KICK_ON_MAX_TRIGGERS:
        {
            new year, month, day, hour, minute, second;
            gettime(hour, minute, second);
            getdate(year, month, day);

            format(HYAXE_UNSAFE_HUGE_STRING, HYAXE_UNSAFE_HUGE_LENGTH, 
                "{DADADA}Fuiste expulsado del servidor.\n\n\
                    {CB3126}Razón de la expulsión\n\
                        \t{DADADA}%s\n\n\
                    {CB3126}Administrador encargado\n\
                        \t{DADADA}Anticheat\n\n\
                    {CB3126}Fecha\n\
                        \t{DADADA}%i/%i/%i %i:%i:%i\
                ",
                    g_rgeDetectionData[cheat][e_szDetectionName],
                    day, month, year, hour, minute, second
            );

            Dialog_Show(playerid, "kick", DIALOG_STYLE_MSGBOX, "{CB3126}Hyaxe {DADADA}- Expulsión", HYAXE_UNSAFE_HUGE_STRING, "Salir");

            KickTimed(playerid, 500);

            format(HYAXE_UNSAFE_HUGE_STRING, HYAXE_UNSAFE_HUGE_LENGTH,
                "› {DADADA}El jugador {415BA2}%s {DADADA}(ID {415BA2}%i{DADADA}) fue expulsado por el {415BA2}anticheat{DADADA}: %s", 
                Player_RPName(playerid), playerid, g_rgeDetectionData[cheat][e_szDetectionName]
            );
            Admins_SendMessage(RANK_LEVEL_MODERATOR, 0x415BA2FF, HYAXE_UNSAFE_HUGE_STRING);
        }
        case PUNISHMENT_BAN, PUNISHMENT_BAN_ON_MAX_TRIGGERS:
        {
            Player_Ban(playerid, ADMIN_ID_ANTICHEAT, g_rgeDetectionData[cheat][e_szDetectionName]);

            format(HYAXE_UNSAFE_HUGE_STRING, HYAXE_UNSAFE_HUGE_LENGTH,
                "{DADADA}El jugador {415BA2}%s{DADADA} ({415BA2}%i{DADADA}-{415BA2}%i{DADADA}) fue vetado por el {415BA2}anticheat{DADADA}: %s",
                Player_RPName(playerid), playerid, Player_AccountID(playerid), g_rgeDetectionData[cheat][e_szDetectionName]
            );
            Admins_SendMessage(RANK_LEVEL_MODERATOR, 0x415BA2FF, HYAXE_UNSAFE_HUGE_STRING);
        }
    }

    return 1;
}

bool:Player_HasImmunityForCheat(playerid, eCheats:cheat)
{
    return g_rgiAnticheatImmunity[playerid][cheat] && GetTickDiff(g_rgiAnticheatImmunity[playerid][cheat], GetTickCount()) > 0;
}

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

#if defined _ALS_SetPlayerChatBubble
    #undef SetPlayerChatBubble
#else
    #define _ALS_SetPlayerChatBubble
#endif
#define SetPlayerChatBubble ac_SetPlayerChatBubble
