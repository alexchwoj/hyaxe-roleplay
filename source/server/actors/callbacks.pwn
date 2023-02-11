#if defined _actors_callbacks_
    #endinput
#endif
#define _actors_callbacks_

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
    if ((newkeys & KEY_CTRL_BACK) != 0 && GetWeaponSlot(GetPlayerWeapon(playerid)) > 0)
    {
        new actorid = GetPlayerTargetDynamicActor(playerid);
        if (actorid != INVALID_STREAMER_ID)
        {
            if (Actor_Rob(playerid, actorid))
                return 1;
        }
    }

    #if defined ROB_OnPlayerKeyStateChange
        return ROB_OnPlayerKeyStateChange(playerid, newkeys, oldkeys);
    #else
        return 1;
    #endif
}

#if defined _ALS_OnPlayerKeyStateChange
    #undef OnPlayerKeyStateChange
#else
    #define _ALS_OnPlayerKeyStateChange
#endif
#define OnPlayerKeyStateChange ROB_OnPlayerKeyStateChange
#if defined ROB_OnPlayerKeyStateChange
    forward ROB_OnPlayerKeyStateChange(playerid, newkeys, oldkeys);
#endif

public ROBBERY_Progress(playerid, actorid, phase)
{
    new id = Streamer_GetIntData(STREAMER_TYPE_ACTOR, actorid, E_STREAMER_CUSTOM(0x524F42));

    switch (phase)
    {
        case 0:
        {
            ApplyDynamicActorAnimation(actorid, "SHOP", "SHP_SERVE_LOOP", 4.1, true, false, false, false, 0);
            g_rgeRobbableActors[id][e_iRobberyTimer] = SetTimerEx("ROBBERY_Progress", 10000, false, "iii", playerid, actorid, 1);
        }
        case 1:
        {
            ApplyDynamicActorAnimation(actorid, "SHOP", "SHP_ROB_HANDSUP", 4.1, false, false, false, true, 0);
            g_rgeRobbableActors[id][e_iRobberyTimer] = SetTimerEx("ROBBERY_Progress", 3000, false, "iii", playerid, actorid, 2);
        }
        case 2:
        {
            /*
            if ((random(100) + 1) % 2)
            {
                // Shopkeeper picked up a shotgun
            }
            else
            {*/
            ApplyDynamicActorAnimation(actorid, "SHOP", "SHP_ROB_GIVECASH", 4.1, false, false, false, true, 0);

            new money = Random(g_rgeRobbableActors[id][e_iMinMoneyReward], g_rgeRobbableActors[id][e_iMaxMoneyReward]);
            Player_GiveMoney(playerid, money);

            new message[85];
            format(message, sizeof(message), "Robaste la tienda y recibiste ~g~$%i~w~. Huye antes de que venga la policía.", money);
            Notification_Show(playerid, message, 7000);
            //}

            g_rgeRobbableActors[id][e_iLastStealTick] = GetTickCount();
            g_rgeRobbableActors[id][e_iRobbingPlayer] = INVALID_PLAYER_ID;
            g_rgeRobbableActors[id][e_iRobberyTimer] = 0;

            Bit_Set(Player_Flags(playerid), PFLAG_ROBBING_STORE, false);

            Police_AddChargesToPlayer(playerid, 2);

            new city[45], zone[45];
            GetPointZone(g_rgeEnterExits[ Player_LastEnterExit(playerid) ][e_fExitX], g_rgeEnterExits[ Player_LastEnterExit(playerid) ][e_fExitY], city, zone);
            Police_SendMessage(POLICE_RANK_OFFICER, 0x3A86FFFF, va_return("[Policía] ›{DADADA} %s ha robado una tienda en %s, %s.", Player_RPName(playerid), zone, city));
        }
    }

    return 1;
}