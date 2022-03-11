#if defined _jobs_header_
    #endinput
#endif
#define _jobs_header_

enum eJobs
{
    JOB_NONE,
    JOB_GUNSMAKER,
    JOB_LAWNMOWER
};

enum eJobEvent
{
    JOB_EV_JOIN,
    JOB_EV_LEAVE,
    JOB_EV_LEAVE_PLACE,
    JOB_EV_LEAVE_VEHICLE
};

enum ePlayerJobData
{
    eJobs:e_iPlayerCurrentJob,
    e_iPlayerPaycheck
};

new 
    g_rgePlayerJobData[MAX_PLAYERS + 1][ePlayerJobData],
    g_rgePlayerJobCallbacks[eJobs] = { -1, ... };

new const
    g_rgszJobNames[eJobs][] = {
        "Ninguno",
        "Fabricante de armas",
        "Cortacésped"
    };

#define Player_Job(%0) (g_rgePlayerJobData[(%0)][e_iPlayerCurrentJob])
#define PlayerJob_Paycheck(%0) (g_rgePlayerJobData[(%0)][e_iPlayerPaycheck])

forward Job_CreateSite(eJobs:jobid, Float:x, Float:y, Float:z, vw, interior, const extra_text[] = "", cb_data = cellmin);
forward Job_SetCallback(eJobs:jobid, callback);
forward Job_TriggerCallback(playerid, eJobs:jobid, eJobEvent:event, data = -1);