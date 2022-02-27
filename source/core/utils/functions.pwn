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

Float:fclamp(Float:v, Float:min, Float:max)
{
    return (v < min ? min : (v > max ? max : v));
}

stock memset(arr[], val = 0, size = sizeof (arr))
{
	new
		addr = 0;
	#emit LOAD.S.pri arr
	#emit STOR.S.pri addr
	// Convert the size from cells to bytes.
	return rawMemset(addr, val, size * cellbytes);
}


stock rawMemset(address /* 12 */, value /* 16 */, size /* 20 */)
{
	if (size < cellbytes)
		return 0;
	if (address < 0)
	{
		// Somewhere in COD, not DAT.  Can't use FILL because it checks the
		// address.  Unless we are running in the JIT, which doesn't have
		// checks, but we shouldn't be writing to COD after the JIT has started
		// anyway.
		do
		{
			#emit LOAD.S.pri value
			#emit SREF.S.pri address
			address += cellbytes;
		}
		while ((size -= cellbytes) > 0);
		return 1;
	}
	else
	{
		while (size >= 4096)
		{
			#emit LOAD.S.pri value
			#emit LOAD.S.alt address
			#emit FILL       4096
			address += 4096;
			size -= 4096;
		}
		if (size & 2048)
		{
			#emit LOAD.S.pri value
			#emit LOAD.S.alt address
			#emit FILL       2048
			address += 2048;
		}
		if (size & 1024)
		{
			#emit LOAD.S.pri value
			#emit LOAD.S.alt address
			#emit FILL       1024
			address += 1024;
		}
		if (size & 512)
		{
			#emit LOAD.S.pri value
			#emit LOAD.S.alt address
			#emit FILL       512
			address += 512;
		}
		if (size & 256)
		{
			#emit LOAD.S.pri value
			#emit LOAD.S.alt address
			#emit FILL       256
			address += 256;
		}
		if (size & 128)
		{
			#emit LOAD.S.pri value
			#emit LOAD.S.alt address
			#emit FILL       128
			address += 128;
		}
		if (size & 64)
		{
			#emit LOAD.S.pri value
			#emit LOAD.S.alt address
			#emit FILL       64
			address += 64;
		}
		if (size & 32)
		{
			#emit LOAD.S.pri value
			#emit LOAD.S.alt address
			#emit FILL       32
			address += 32;
		}
		if (size & 16)
		{
			#emit LOAD.S.pri value
			#emit LOAD.S.alt address
			#emit FILL       16
			address += 16;
		}
		if (size & 8)
		{
			#emit LOAD.S.pri value
			#emit LOAD.S.alt address
			#emit FILL       8
			address += 8;
		}
		if (size & 4)
		{
			#emit LOAD.S.pri value
			#emit SREF.S.pri address
		}
		return 1;
	}
}

Float:lerp(Float:start_value, Float:end_value, Float:pct)
{
    return (start_value + (end_value - start_value) * pct);
}
