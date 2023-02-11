#if defined _jobs_functions_
    #endinput
#endif
#define _jobs_functions_

static JobSite_OnPress(playerid, data)
{
    if (Police_OnDuty(playerid))
    {
        Notification_ShowBeatingText(playerid, 3000, 0xED2B2B, 100, 255, "No puedes hacer esto de servicio como policía");
        return 1;
    }

    new jobid = (data & 0xFFFF);
    new cb_data = (data >>> 16);

    if (Player_Job(playerid) == JOB_NONE)
    {
        if (Job_TriggerCallback(playerid, eJobs:jobid, JOB_EV_JOIN, cb_data))
            Player_Job(playerid) = eJobs:jobid;
    }
    else if (Player_Job(playerid) == eJobs:jobid)
    {
        if (Job_TriggerCallback(playerid, eJobs:jobid, JOB_EV_LEAVE, cb_data))
            Player_Job(playerid) = JOB_NONE;
    }
    else
    {
        Notification_ShowBeatingText(playerid, 3000, 0xED2B2B, 100, 255, "Ya tienes un trabajo");
    }

    return 1;
}

Job_CreateSite(eJobs:jobid, Float:x, Float:y, Float:z, vw, interior, const extra_text[] = "", cb_data = 0)
{
    if (!(0 <= cb_data < 0xFFFF))
    {
        printf("[jobs!] cb_data (%d) can't be higher than 0xFFFF or lower than 0 (for job %d)", cb_data, _:jobid);
        return 1;
    }

    new labelstring[256];
    format(labelstring, sizeof(labelstring), "Trabajo de {CB3126}%s{DADADA}\nPresiona {CB3126}Y{DADADA} para empezar a trabajar\n%s", g_rgszJobNames[jobid], extra_text);

    CreateDynamic3DTextLabel(labelstring, 0xDADADAFF, x, y, z, 10.0, .testlos = 1, .worldid = vw, .interiorid = interior);
    Key_Alert(x, y, z, 3.0, KEYNAME_YES, vw, interior, _, _, __addressof(JobSite_OnPress), (cb_data << 16) | _:jobid);

    return 1;
}

Job_SetCallback(eJobs:jobid, callback)
{
    g_rgePlayerJobCallbacks[jobid] = callback;
    return 1;
}

Job_TriggerCallback(playerid, eJobs:jobid, eJobEvent:event, data = 0)
{
    if (g_rgePlayerJobCallbacks[jobid] != -1)
    {
        new cb_addr = g_rgePlayerJobCallbacks[jobid];

        // For some reason, placing a "retn" opcode gives runtime error 5 (Invalid memory access)
        return __emit(
            push.s data,
            push.s event,
            push.s playerid,
            push.c 12,
            lctrl 6,
            add.c 0x24,
            lctrl 8,
            push.pri,
            load.s.pri cb_addr,
            sctrl 6
        );
    }

    return 1;
}

Job_ApplyPaycheckBenefits(playerid, amount)
{
    static const added_percentage_per_level[] = { 0, 5, 20, 80 };
    return amount + (amount * Percent:added_percentage_per_level[Player_VIP(playerid)]);
}