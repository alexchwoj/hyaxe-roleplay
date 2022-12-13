#if defined _jobs_commands_
    #endinput
#endif
#define _jobs_commands_

command trabajo(playerid, const params[], "Muestra tu trabajo o renuncia a él")
{
    if (!Player_Job(playerid))
    {
        SendClientMessage(playerid, 0xED2B2BFF, "›{DADADA} No tienes trabajo.");
        return 1;
    }

    if (!strcmp(params, "renunciar", true, 9))
    {
        SendClientMessagef(playerid, 0xCB3126FF, "›{DADADA} Renunciaste a tu trabajo como {CB3126}%s{DADADA}.", g_rgszJobNames[Player_Job(playerid)]);
        PlayerJob_Paycheck(playerid) = 0;
        Job_TriggerCallback(playerid, Player_Job(playerid), JOB_EV_RESIGN);
        Player_Job(playerid) = JOB_NONE;

        return 1;
    }

    SendClientMessagef(playerid, 0xCB3126FF, "›{DADADA} Estás en jornada como {CB3126}%s{DADADA}.", g_rgszJobNames[Player_Job(playerid)]);
    SendClientMessagef(playerid, 0xCB3126FF, "›{DADADA} Paga pendiente: {64A752}$%d", PlayerJob_Paycheck(playerid));
    SendClientMessage(playerid, 0xCB3126FF, "›{DADADA} Para renunciar a tu trabajo usa {CB3126}/trabajo renunciar");
    
    if (PlayerJob_Paycheck(playerid))
        SendClientMessage(playerid, 0xCB3126FF, "› ADVERTENCIA: {DADADA}Si renuncias, no podrás cobrar tu paga pendiente.");

    return 1;
}