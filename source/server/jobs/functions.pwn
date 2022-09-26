#if defined _jobs_functions_
    #endinput
#endif
#define _jobs_functions_

Job_CreateSite(eJobs:jobid, Float:x, Float:y, Float:z, vw, interior, const extra_text[] = "", cb_data = cellmin)
{
    new labelstring[256];
    format(labelstring, sizeof(labelstring), "Trabajo de {CB3126}%s{DADADA}\nPresiona {CB3126}Y{DADADA} para empezar a trabajar\n%s", g_rgszJobNames[jobid], extra_text);

    CreateDynamic3DTextLabel(labelstring, 0xDADADAFF, x, y, z, 10.0, .testlos = 1, .worldid = vw, .interiorid = interior);
    new area = CreateDynamicCircle(x, y, 3.0, .worldid = vw, .interiorid = interior);
    new info[2];
    info[0] = _:jobid;
    info[1] = cb_data;
    Streamer_SetArrayData(STREAMER_TYPE_AREA, area, E_STREAMER_CUSTOM(0x4A4F42), info); // JOB

    Key_Alert(x, y, z, 1.5, KEYNAME_YES, vw, interior);
    return 1;
}

Job_SetCallback(eJobs:jobid, callback)
{
    g_rgePlayerJobCallbacks[jobid] = callback;
    return 1;
}

Job_TriggerCallback(playerid, eJobs:jobid, eJobEvent:event, data = -1)
{
    if(g_rgePlayerJobCallbacks[jobid] != -1)
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
    if(!Player_VIP(playerid))
        return amount;

    static const added_percentage_per_level[] = { 0, 5, 20, 80 };
    return (amount * added_percentage_per_level[Player_VIP(playerid)]) / 100;
}