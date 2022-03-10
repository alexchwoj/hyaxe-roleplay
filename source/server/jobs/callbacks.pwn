#if defined _jobs_callbacks_
    #endinput
#endif
#define _jobs_callbacks_

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
    if((newkeys & KEY_YES) != 0)
    {
        if(IsPlayerInAnyDynamicArea(playerid))
        {
            new areas[1];
            GetPlayerDynamicAreas(playerid, areas);

            new info[3];
            Streamer_GetArrayData(STREAMER_TYPE_AREA, areas[0], E_STREAMER_EXTRA_ID, info);
            if(info[0] == 0x4A4F42)
            {
                DEBUG_PRINT("info[3] = { %i, %i, %i }", info[0], info[1], info[2]);
                if(Player_Job(playerid) == JOB_NONE)
                {
                    if(Job_TriggerCallback(playerid, eJobs:info[1], JOB_EV_JOIN, info[2]))
                        Player_Job(playerid) = eJobs:info[1];
                }
                else if(Player_Job(playerid) == eJobs:info[1])
                {
                    if(Job_TriggerCallback(playerid, eJobs:info[1], JOB_EV_LEAVE, info[2]))
                        Player_Job(playerid) = JOB_NONE;
                }

                return 1;
            }
        }
    }

    #if defined JOBS_OnPlayerKeyStateChange
        return JOBS_OnPlayerKeyStateChange(playerid, newkeys, oldkeys);
    #else
        return 1;
    #endif
}

#if defined _ALS_OnPlayerKeyStateChange
    #undef OnPlayerKeyStateChange
#else
    #define _ALS_OnPlayerKeyStateChange
#endif
#define OnPlayerKeyStateChange JOBS_OnPlayerKeyStateChange
#if defined JOBS_OnPlayerKeyStateChange
    forward JOBS_OnPlayerKeyStateChange(playerid, newkeys, oldkeys);
#endif
