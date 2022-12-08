#if defined _admin_header_
    #endinput
#endif
#define _admin_header_

new
    Iterator:Admin<MAX_PLAYERS>;

forward Admins_SendMessage(level, color, const message[], bool:webhook = true);
forward Admins_SendMessage_s(level, color, ConstString:message);
forward Player_Ban(playerid, adminid, const reason[] = "No especificada", time_seconds = -1);
forward Account_Ban(const account_name[], adminid, const reason[] = "No especificada", time_seconds = -1);

#define Player_GetRankName(%0) (g_rgszRankLevelNames[Player_AdminLevel(%0)][Player_Sex(%0)])