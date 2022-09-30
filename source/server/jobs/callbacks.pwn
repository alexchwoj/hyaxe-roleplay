#if defined _jobs_callbacks_
    #endinput
#endif
#define _jobs_callbacks_

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
    if((newkeys & KEY_YES) != 0)
    {
        new areas = GetPlayerNumberDynamicAreas(playerid);
        if (areas)
        {
            YSI_UNSAFE_HUGE_STRING[areas] = INVALID_STREAMER_ID;
            GetPlayerDynamicAreas(playerid, YSI_UNSAFE_HUGE_STRING, YSI_UNSAFE_HUGE_LENGTH);
            
            for(new i; YSI_UNSAFE_HUGE_STRING[i] != INVALID_STREAMER_ID; ++i)
            {
                new areaid = YSI_UNSAFE_HUGE_STRING[i];
                if(Streamer_HasArrayData(STREAMER_TYPE_AREA, areaid, E_STREAMER_CUSTOM(0x4A4F42)))
                {
                    new info[2];
                    Streamer_GetArrayData(STREAMER_TYPE_AREA, areaid, E_STREAMER_CUSTOM(0x4A4F42), info);

                    if(Player_Job(playerid) == JOB_NONE)
                    {
                        if(Job_TriggerCallback(playerid, eJobs:info[0], JOB_EV_JOIN, info[1]))
                            Player_Job(playerid) = eJobs:info[0];
                    }
                    else if(Player_Job(playerid) == eJobs:info[0])
                    {
                        if(Job_TriggerCallback(playerid, eJobs:info[0], JOB_EV_LEAVE, info[1]))
                            Player_Job(playerid) = JOB_NONE;
                    }

                    return 1;
                }
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
