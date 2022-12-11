#if defined _grill_callbacks_
    #endinput
#endif
#define _grill_callbacks_

public OnPlayerDisconnect(playerid, reason)
{
    if (!Player_Grill(playerid))
    {
        Grill_Destroy(Player_Grill(playerid));
        Player_Grill(playerid) = INVALID_STREAMER_ID;
    }

    #if defined GRILL_OnPlayerDisconnect
        return GRILL_OnPlayerDisconnect(playerid, reason);
    #else
        return 1;
    #endif
}

#if defined _ALS_OnPlayerDisconnect
    #undef OnPlayerDisconnect
#else
    #define _ALS_OnPlayerDisconnect
#endif
#define OnPlayerDisconnect GRILL_OnPlayerDisconnect
#if defined GRILL_OnPlayerDisconnect
    forward GRILL_OnPlayerDisconnect(playerid, reason);
#endif

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
    if((newkeys & KEY_CTRL_BACK) != 0)
    {
        new grill_id = Player_GetNearestGrill(playerid);
        if (grill_id != INVALID_STREAMER_ID)
        {
            new data[eGrillData];
            Streamer_GetArrayData(STREAMER_TYPE_AREA, grill_id, E_STREAMER_CUSTOM(MAKE_CELL(0,'B','B','Q')), data);

            if (data[e_iOwnerID] == playerid)
            {
                Grill_Destroy(grill_id);
                Inventory_AddFixedItem(playerid, ITEM_GRILL, 1, 0);
                ApplyAnimation(playerid, "BOMBER", "BOM_Plant", 4.1, 0, 0, 0, 0, 1000, 1);
                Notification_Show(playerid, "Has levantado tu parrilla.", 3000, 0xDD6A4DFF);
                Chat_SendAction(playerid, "levanta su parrilla");
            }
        }
    }

    #if defined BBQ_OnPlayerKeyStateChange
        return BBQ_OnPlayerKeyStateChange(playerid, newkeys, oldkeys);
    #else
        return 1;
    #endif
}

#if defined _ALS_OnPlayerKeyStateChange
    #undef OnPlayerKeyStateChange
#else
    #define _ALS_OnPlayerKeyStateChange
#endif
#define OnPlayerKeyStateChange BBQ_OnPlayerKeyStateChange
#if defined BBQ_OnPlayerKeyStateChange
    forward BBQ_OnPlayerKeyStateChange(playerid, newkeys, oldkeys);
#endif
