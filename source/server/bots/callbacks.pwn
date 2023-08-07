#if defined _bots_callbacks_
    #endinput
#endif
#define _bots_callbacks_

public OnPlayerConnect(playerid)
{
    if (!IsPlayerNPC(playerid))
    {
        new ip_address[16];
        GetPlayerIp(playerid, ip_address, 16);

        for (new i; i < sizeof(g_szBotAddressWhitelist); ++i)
        {
            if(!strcmp(ip_address, g_szBotAddressWhitelist[i]))
            {
                TogglePlayerFakePing(playerid, true);
                Player_Bot(playerid) = true;
                g_iPingTimer{playerid} = SetTimerEx("BOT_UpdatePing", 1000, true, "i", playerid);
                break;
            }
        }
    }

    #if defined BOT_OnPlayerConnect
        return BOT_OnPlayerConnect(playerid);
    #else
        return 1;
    #endif
}

#if defined _ALS_OnPlayerConnect
    #undef OnPlayerConnect
#else
    #define _ALS_OnPlayerConnect
#endif
#define OnPlayerConnect BOT_OnPlayerConnect
#if defined BOT_OnPlayerConnect
    forward BOT_OnPlayerConnect(playerid);
#endif

public OnPlayerDisconnect(playerid, reason)
{
    KillTimer(g_iPingTimer{playerid});
    TogglePlayerFakePing(playerid, false);
    Player_Bot(playerid) = false;

    #if defined BOT_OnPlayerDisconnect
        return BOT_OnPlayerDisconnect(playerid, reason);
    #else
        return 1;
    #endif
}

#if defined _ALS_OnPlayerDisconnect
    #undef OnPlayerDisconnect
#else
    #define _ALS_OnPlayerDisconnect
#endif
#define OnPlayerDisconnect BOT_OnPlayerDisconnect
#if defined BOT_OnPlayerDisconnect
    forward BOT_OnPlayerDisconnect(playerid, reason);
#endif

forward BOT_UpdatePing(playerid);
public BOT_UpdatePing(playerid)
{
    SetPlayerFakePing(playerid, 190 + random(90));
    return 1;
}