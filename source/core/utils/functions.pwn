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

Str_FixEncoding(const string[])
{
    static result[1024];
    strcpy(result, string);

    for (new i = (strlen(result) - 1); i != -1; --i)
    {
        switch (result[i])
        {
            case 'à': result[i] = 151;
            case 'á': result[i] = 152;
            case 'â': result[i] = 153;
            case 'ä': result[i] = 154;
            case 'À': result[i] = 128;
            case 'Á': result[i] = 129;
            case 'Â': result[i] = 130;
            case 'Ä': result[i] = 131;
            case 'è': result[i] = 157;
            case 'é': result[i] = 158;
            case 'ê': result[i] = 159;
            case 'ë': result[i] = 160;
            case 'È': result[i] = 134;
            case 'É': result[i] = 135;
            case 'Ê': result[i] = 136;
            case 'Ë': result[i] = 137;
            case 'ì': result[i] = 161;
            case 'í': result[i] = 162;
            case 'î': result[i] = 163;
            case 'ï': result[i] = 164;
            case 'Ì': result[i] = 138;
            case 'Í': result[i] = 139;
            case 'Î': result[i] = 140;
            case 'Ï': result[i] = 141;
            case 'ò': result[i] = 165;
            case 'ó': result[i] = 166;
            case 'ô': result[i] = 167;
            case 'ö': result[i] = 168;
            case 'Ò': result[i] = 142;
            case 'Ó': result[i] = 143;
            case 'Ô': result[i] = 144;
            case 'Ö': result[i] = 145;
            case 'ù': result[i] = 169;
            case 'ú': result[i] = 170;
            case 'û': result[i] = 171;
            case 'ü': result[i] = 172;
            case 'Ù': result[i] = 146;
            case 'Ú': result[i] = 147;
            case 'Û': result[i] = 148;
            case 'Ü': result[i] = 149;
            case 'ñ': result[i] = 174;
            case 'Ñ': result[i] = 173;
            case '¡': result[i] = 64;
            case '¿': result[i] = 175;
            case '`': result[i] = 177;
            case '&': result[i] = 38;
        }
    }

    return result;
}

Str_FixEncoding_Ref(result[])
{
	for (new i = (strlen(result) - 1); i != -1; --i)
    {
        switch (result[i])
        {
            case 'à': result[i] = 151;
            case 'á': result[i] = 152;
            case 'â': result[i] = 153;
            case 'ä': result[i] = 154;
            case 'À': result[i] = 128;
            case 'Á': result[i] = 129;
            case 'Â': result[i] = 130;
            case 'Ä': result[i] = 131;
            case 'è': result[i] = 157;
            case 'é': result[i] = 158;
            case 'ê': result[i] = 159;
            case 'ë': result[i] = 160;
            case 'È': result[i] = 134;
            case 'É': result[i] = 135;
            case 'Ê': result[i] = 136;
            case 'Ë': result[i] = 137;
            case 'ì': result[i] = 161;
            case 'í': result[i] = 162;
            case 'î': result[i] = 163;
            case 'ï': result[i] = 164;
            case 'Ì': result[i] = 138;
            case 'Í': result[i] = 139;
            case 'Î': result[i] = 140;
            case 'Ï': result[i] = 141;
            case 'ò': result[i] = 165;
            case 'ó': result[i] = 166;
            case 'ô': result[i] = 167;
            case 'ö': result[i] = 168;
            case 'Ò': result[i] = 142;
            case 'Ó': result[i] = 143;
            case 'Ô': result[i] = 144;
            case 'Ö': result[i] = 145;
            case 'ù': result[i] = 169;
            case 'ú': result[i] = 170;
            case 'û': result[i] = 171;
            case 'ü': result[i] = 172;
            case 'Ù': result[i] = 146;
            case 'Ú': result[i] = 147;
            case 'Û': result[i] = 148;
            case 'Ü': result[i] = 149;
            case 'ñ': result[i] = 174;
            case 'Ñ': result[i] = 173;
            case '¡': result[i] = 64;
            case '¿': result[i] = 175;
            case '`': result[i] = 177;
            case '&': result[i] = 38;
        }
    }
}

SplitMessageInLines(const string[], result[][], max_lines = sizeof(result), max_line_length = sizeof(result[]))
{
	DEBUG_PRINT("SplitMessageInLines(string[%i], result[%i][%i])", strlen(string), max_lines, max_line_length);

	new len = strlen(string);
	if(len < max_line_length)
	{
		strcpy(result[0], string, max_line_length);
		return 1;
	}

	new regex_str[32];
	format(regex_str, sizeof(regex_str), ".{1,%i}(\\s|$)", max_line_length);
	new Regex:rgx = Regex_New(regex_str);
	
	new RegexMatch:match, pos, startpos, line_count;
	while(Regex_Search(string, rgx, match, pos, startpos))
	{
		new length;
		Match_GetGroup(match, 0, result[line_count], length, max_line_length);
		if(result[line_count][length - 1] == ' ')
			result[line_count][length - 1] = '\0';

		line_count++;
		startpos += pos + length;

		Match_Free(match);
	}

	Regex_Delete(rgx);

	return line_count;
}

Date_ToString(year, month, day)
{
	static const month_names[][] = { "enero", "febrero", "marzo", "abril", "mayo", "junio", "julio", "agosto", "septiembre", "octubre", "noviembre", "diciembre" };

	new str[32];
	format(str, sizeof(str), "%i de %s del %i", day, month_names[month], year);
	return str;
}

Format_Thousand(number)
{
	new string[32], bool:negative;
	format(string, sizeof string, "%d", number);
	if (number < 0)
	{
		negative = true;
		strdel(string, 0, 1);
	}

	new numbers = strlen(string);
	while(numbers > 3)
	{
		numbers -= 3;
		strins(string, ".", numbers);
	}

	if (negative) strins(string, "-", 0);
	return string;
}