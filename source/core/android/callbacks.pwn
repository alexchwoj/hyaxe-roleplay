#if defined _android_callbacks_
    #endinput
#endif
#define _android_callbacks_

static 
    s_rgbAndroidTimer[MAX_PLAYERS];

const __android_RPC_ClientJoin = 25;
IRPC:__android_RPC_ClientJoin(playerid, BitStream:bs)
{
    new nickname_len, authkey_len, version_len;
    BS_ReadValue(bs,
        PR_IGNORE_BITS, 40,
        PR_UINT8, nickname_len,
        PR_IGNORE_BITS, (nickname_len * 8) + 32,
        PR_UINT8, authkey_len,
        PR_IGNORE_BITS, authkey_len * 8,
        PR_UINT8, version_len,
        PR_IGNORE_BITS, version_len * 8
    );

    new bits_unread;
    BS_GetNumberOfUnreadBits(bs, bits_unread);
    if(bits_unread >= 32)
        g_rgbIsAndroid{playerid} = true;

    return 1;
}

public OnPlayerConnect(playerid)
{
    if (!g_rgbIsAndroid{playerid})
    {
        SendClientCheck(playerid, 0x48, 0, 0, 2);
        s_rgbAndroidTimer[playerid] = SetTimerEx("HY_ANDROID_FlagAsAndroid", 10000, false, "i", playerid);
    }

    #if defined HY_ANDROID_OnPlayerConnect
        return HY_ANDROID_OnPlayerConnect(playerid);
    #else
        return 1;
    #endif
}

#if defined _ALS_OnPlayerConnect
    #undef OnPlayerConnect
#else
    #define _ALS_OnPlayerConnect
#endif
#define OnPlayerConnect HY_ANDROID_OnPlayerConnect
#if defined HY_ANDROID_OnPlayerConnect
    forward HY_ANDROID_OnPlayerConnect(playerid);
#endif

forward HY_ANDROID_FlagAsAndroid(playerid);
public HY_ANDROID_FlagAsAndroid(playerid)
{
    g_rgbIsAndroid{playerid} = true;
    s_rgbAndroidTimer[playerid] = 0;
}

public OnClientCheckResponse(playerid, actionid, memaddr, retndata)
{
    if (actionid == 0x48)
    {
        g_rgbIsAndroid{playerid} = false;
        if (s_rgbAndroidTimer[playerid])
            Timer_Kill(s_rgbAndroidTimer[playerid]);
    }

    #if defined HY_DROID_OnClientCheckResponse
        return HY_DROID_OnClientCheckResponse(playerid, actionid, memaddr, retndata);
    #else
        return 1;
    #endif
}

#if defined _ALS_OnClientCheckResponse
    #undef OnClientCheckResponse
#else
    #define _ALS_OnClientCheckResponse
#endif
#define OnClientCheckResponse HY_DROID_OnClientCheckResponse
#if defined HY_DROID_OnClientCheckResponse
    forward HY_DROID_OnClientCheckResponse(playerid, actionid, memaddr, retndata);
#endif

public OnPlayerDisconnect(playerid, reason)
{
    g_rgbIsAndroid{playerid} = false;
    if (s_rgbAndroidTimer[playerid])
        Timer_Kill(s_rgbAndroidTimer[playerid]);

    #if defined HY_ANDROID_OnPlayerDisconnect
        return HY_ANDROID_OnPlayerDisconnect(playerid, reason);
    #else
        return 1;
    #endif
}

#if defined _ALS_OnPlayerDisconnect
    #undef OnPlayerDisconnect
#else
    #define _ALS_OnPlayerDisconnect
#endif
#define OnPlayerDisconnect HY_ANDROID_OnPlayerDisconnect
#if defined HY_ANDROID_OnPlayerDisconnect
    forward HY_ANDROID_OnPlayerDisconnect(playerid, reason);
#endif
