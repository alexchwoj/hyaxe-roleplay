#if defined _keygame_callbacks_
    #endinput
#endif
#define _keygame_callbacks_

public KEYGAME_ProcessKey(playerid)
{
    if (!g_rgeKeyGameData[playerid][e_iKgTimers][KG_TIMER_DECREASE_BAR])
    {
        if (g_rgeKeyGameData[playerid][e_fKgCurrentSize] > KEYGAME_BAR_MIN_Y)
        {
            g_rgeKeyGameData[playerid][e_iKgTimers][KG_TIMER_DECREASE_BAR] = SetTimerEx("KEYGAME_DecreaseBar", 1500, true, "i", playerid);
        }
    }

    new keys, ud, lr;
    GetPlayerKeys(playerid, keys, ud, lr);

    new current_key = g_rgiRandomKeys[g_rgeKeyGameData[playerid][e_iKgCurrentKey]];
    if ((current_key & keys) != 0 || ud == current_key || lr == current_key)
    {
        g_rgeKeyGameData[playerid][e_bKgKeyRed] = false;
        g_rgeKeyGameData[playerid][e_fKgCurrentSize] = fclamp(g_rgeKeyGameData[playerid][e_fKgCurrentSize] + g_rgeKeyGameData[playerid][e_fKgPercentagePerKey], KEYGAME_BAR_MIN_Y, KEYGAME_BAR_MAX_Y);
        
        TextDrawTextSize(g_tdKeyGame{1}, 298.500, g_rgeKeyGameData[playerid][e_fKgCurrentSize]);
        TextDrawShowForPlayer(playerid, g_tdKeyGame[1]);

        if (g_rgeKeyGameData[playerid][e_fKgCurrentSize] >= KEYGAME_BAR_MAX_Y)
        {
            new cb = g_rgeKeyGameData[playerid][e_pKgCallback];
            Player_StopKeyGame(playerid);
            
            __emit {                // callback(playerid, bool:success)
                push.c true         // bool:success
                push.s playerid     // playerid
                push.c 8
                lctrl 6
                add.c 0x24
                lctrl 8
                push.pri
                load.s.pri cb
                sctrl 6
            }
        }
        else
        {
            new next_key;
            do
            {
                next_key = random(sizeof(g_rgiRandomKeys));
            } 
            while (next_key == g_rgeKeyGameData[playerid][e_iKgCurrentKey]);

            g_rgeKeyGameData[playerid][e_iKgCurrentKey] = next_key;
            PlayerPlaySound(playerid, 11200);

            PlayerTextDrawSetString(playerid, p_tdKeyGame{playerid}, g_rgszKeyNames[g_rgeKeyGameData[playerid][e_iKgCurrentKey]]);
            g_rgeKeyGameData[playerid][e_iKgLastKeyAppearance] = GetTickCount();
        }
    }
    else
    {
        if (!g_rgeKeyGameData[playerid][e_bKgKeyRed] && GetTickCount() - g_rgeKeyGameData[playerid][e_iKgLastKeyAppearance] >= 5000)
        {
            g_rgeKeyGameData[playerid][e_bKgKeyRed] = true;
            g_rgeKeyGameData[playerid][e_iKgKeyRedTick] = GetTickCount();

            new keystr[32];
            format(keystr, sizeof(keystr), "~r~%s", g_rgszKeyNames[g_rgeKeyGameData[playerid][e_iKgCurrentKey]]);
            PlayerTextDrawSetString(playerid, p_tdKeyGame{playerid}, keystr);
        }
        else if (g_rgeKeyGameData[playerid][e_bKgKeyRed] && GetTickCount() - g_rgeKeyGameData[playerid][e_iKgKeyRedTick] >= 5000)
        {
            new cb = g_rgeKeyGameData[playerid][e_pKgCallback];
            Player_StopKeyGame(playerid);
            
            __emit {                // callback(playerid, bool:success)
                push.c false        // bool:success
                push.s playerid     // playerid
                push.c 8
                lctrl 6
                add.c 0x24
                lctrl 8
                push.pri
                load.s.pri cb
                sctrl 6
            }
        }
    }

    return 1;
}

public KEYGAME_DecreaseBar(playerid)
{
    g_rgeKeyGameData[playerid][e_fKgCurrentSize] = fclamp(g_rgeKeyGameData[playerid][e_fKgCurrentSize] - g_rgeKeyGameData[playerid][e_fKgDecreaseSec], KEYGAME_BAR_MIN_Y, KEYGAME_BAR_MAX_Y);
    TextDrawTextSize(g_tdKeyGame[1], 298.500, g_rgeKeyGameData[playerid][e_fKgCurrentSize]);
    TextDrawShowForPlayer(playerid, g_tdKeyGame[1]);

    return 1;
}