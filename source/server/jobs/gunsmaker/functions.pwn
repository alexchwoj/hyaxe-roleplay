#if defined _gunsmaker_functions_
    #endinput
#endif
#define _gunsmaker_functions_

Gunsmaker_ProcessQueue()
{
    if (!Iter_Count(GunsmakerBenchQueue))
        return 0;

    new id = Cell_GetLowestBlank(g_iGunsmakerUsedBenchs);
    if (id == sizeof(g_rgfGunsmakerBenchSites))
        return 0;
        
    new playerid = Iter_First(GunsmakerBenchQueue);
    Iter_Remove(GunsmakerBenchQueue, playerid);

    g_iGunsmakerUsedBenchs |= (1 << id);
    g_rgiGunsmakerUsedBench{playerid} = id;
    TogglePlayerDynamicCP(playerid, g_rgiGunsmakerBenchCheckpoint[id], true);
    Streamer_Update(playerid, STREAMER_TYPE_CP);

    Notification_Show(playerid, "Una mesa se liberó y fuiste asignada a ella.", 5000);

    return 1;
}