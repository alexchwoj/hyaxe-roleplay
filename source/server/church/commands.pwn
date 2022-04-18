#if defined _church_commands_
    #endinput
#endif
#define _church_commands_

command misa(playerid, const params[], "Dentro de la iglesia, comienza una misa")
{
    if(g_rgbMassStarted)
    {
        Notification_Show(playerid, "Ya hay una misa en progreso.", 5000);
        return 1;
    }

    if(!IsPlayerInRangeOfPoint(playerid, 2.0, 366.7139, 2330.5049, 1890.6047))
    {
        Notification_Show(playerid, "No estás en la iglesia.", 5000);
        return 1;
    }

    if(g_rgiLastMassTick && GetTickDiff(GetTickCount(), g_rgiLastMassTick) < 300000)
    {
        Notification_Show(playerid, "Debes esperar 5 minutos despues de finalizar la última misa para empezar otra.", 5000);
        return 1;
    }

    Mass_Start(playerid);
    return 1;
}