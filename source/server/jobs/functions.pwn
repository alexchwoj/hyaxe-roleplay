#if defined _jobs_functions_
    #endinput
#endif
#define _jobs_functions_

Job_CreateSite(eJobs:jobid, Float:x, Float:y, Float:z, vw, interior, const extra_text[] = "", cb_data = cellmin)
{
    new labelstring[256];
    format(labelstring, sizeof(labelstring), "Trabajo de {CB3126}%s{DADADA}\nPresiona {CB3126}Y{DADADA} para empezar a trabajar\n%s", g_rgszJobNames[jobid], extra_text);

    CreateDynamic3DTextLabel(labelstring, 0xDADADAFF, x, y, z, 10.0, .testlos = 1, .worldid = vw, .interiorid = interior);
    new area = CreateDynamicCircle(x, y, 1.0, .worldid = vw, .interiorid = interior);
    new info[3];
    info[0] = 0x4A4F42; // 'JOB'
    info[1] = _:jobid;
    info[2] = cb_data;
    Streamer_SetArrayData(STREAMER_TYPE_AREA, area, E_STREAMER_EXTRA_ID, info);

    return 1;
}

Job_SetCallback(eJobs:jobid, callback)
{
    g_rgePlayerJobCallbacks[jobid] = callback;
    return 1;
}

Job_TriggerCallback(playerid, eJobs:jobid, eJobEvent:event, data = -1)
{
    DEBUG_PRINT("Job_TriggerCallback(%i, %i, %i, %i)", playerid, _:jobid, _:event, data);

    if(g_rgePlayerJobCallbacks[jobid] != -1)
    {
        new cb_addr = g_rgePlayerJobCallbacks[jobid];

        // For some reason, placing a "retn" opcode gives runtime error 5 (Invalid memory access)
        new ret = __emit(
            push.c 0,
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

        return ret;
    }

    return 1;
}