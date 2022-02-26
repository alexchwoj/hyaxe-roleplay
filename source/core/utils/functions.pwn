#if defined _utils_functions_
    #endinput
#endif
#define _utils_functions_

GetTickDiff(newtick, oldtick)
{
	if (oldtick > newtick) {
		return (cellmax - oldtick + 1) - (cellmin - newtick);
	}
	return newtick - oldtick;
}

RawIpToString(rawip)
{
	new ip[16];
    format(ip, 16, "%d.%d.%d.%d", (rawip & 0xFF000000), (rawip & 0xFF0000), (rawip & 0xFF00), (rawip & 0xFF));
    return ip;
}

KickTimed(playerid, time = 250)
{
	SetTimerEx(!"KickTimed_Due", time, false, !"i", playerid);
}

forward KickTimed_Due(playerid);
public KickTimed_Due(playerid)
{
	Kick(playerid);
	return 1;
}

/*
Float:fclamp(Float:v, Float:min, Float:max)
{
    return (v < min ? min : (v > max ? max : v));
}
*/
