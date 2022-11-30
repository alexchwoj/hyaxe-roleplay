#if defined _utils_functions_
    #endinput
#endif
#define _utils_functions_

GetTickDiff(newtick, oldtick)
{
	if (oldtick > newtick) 
    {
		return (cellmax - oldtick + 1) - (cellmin - newtick);
	}
	return newtick - oldtick;
}

RawIpToString(rawip)
{
	new ip[16];
    format(ip, 16, "%d.%d.%d.%d", 
        (rawip & 0xFF),
        ((rawip & 0xFF00) >> 8),
        ((rawip & 0xFF0000) >> 16),
        ((rawip & 0xFF000000) >>> 24)
    );

    return ip;
}

stock UTILS_Kick(playerid)
{
    g_rgbPlayerKicked{playerid} = false;
    return Kick(playerid);
}

#if defined _ALS_Kick
    #undef Kick
#else
    #define _ALS_Kick
#endif
#define Kick UTILS_Kick


KickTimed(playerid, time = 250)
{
    g_rgbPlayerKicked{playerid} = true;
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

SplitChatMessageInLines(const string[], result[][], max_lines = sizeof(result), max_line_length = sizeof(result[]))
{
	new len = strlen(string);
	if(len < max_line_length)
	{
		strcpy(result[0], string, max_line_length);
		return 1;
	}

	static Regex:rgx;
    if(!rgx)
        rgx = Regex_New(".{1,144}(\\s|$)");
	
	new RegexMatch:match, pos, startpos, line_count;
	while(Regex_Search(string, rgx, match, pos, startpos) && line_count < max_lines)
	{
		new length;
		Match_GetGroup(match, 0, result[line_count], length, max_line_length);
		if(result[line_count][length - 1] == ' ')
			result[line_count][length - 1] = '\0';

		line_count++;
		startpos += pos + length;

		Match_Free(match);
	}

	return line_count;
}

Date_ToString(year, month, day)
{
	static const month_names[][] = { "enero", "febrero", "marzo", "abril", "mayo", "junio", "julio", "agosto", "septiembre", "octubre", "noviembre", "diciembre" };

	new str[32];
	format(str, sizeof(str), "%i de %s del %i", day, month_names[month - 1], year);
	return str;
}

Format_Thousand(number)
{
	new string[32];
	format(string, sizeof string, "%d", number);

	new const bool:negative = (number < 0);

	for(new i = strlen(string) - 3; i > _:negative; i -= 3)
	{
		strins(string, ".", i);
	}

	return string;
}

Float:CameraLookToAngle(playerid)
{
    new Float:x, Float:y, Float:z;
    GetPlayerCameraFrontVector(playerid, x, y, z);
    return atan2(y, x) + 270.0;
}

GetXYFromAngle(&Float:x, &Float:y, Float:a, Float:distance) 
{
	x += (distance * floatsin(-a, degrees));
	y += (distance * floatcos(-a, degrees));
}

Str_Random(dest[], len = sizeof dest)
{
    dest[len] = '\0';

    while(--len != -1)
    {
        dest[len] = random(2) ? (random(26) + (random(2) ? 'a' : 'A')) : (random(10) + '0');
    }
}

binary_search(const arr[], value, start = 0, end = -1, size = sizeof(arr))
{
    if(end == -1)
        end = size - 1;
    
    while(start <= end)
    {
        new middle = start + (end - start) / 2;
        if(arr[middle] == value)
            return middle;

        if(arr[middle] < value)
            start = middle + 1;
        else
            end = middle - 1;
    }

    return -1;
}

Timer_Kill(&timerid)
{
    KillTimer(timerid);
    return timerid = 0;
}

cache_is_value_name_null_ret(row_idx, const column_name[])
{
    new bool:result;
    cache_is_value_name_null(row_idx, column_name, result);
    return result;
}

stock ReplaceStringByRegex(const str[], const regexp[], const fmt[], dest[], size = sizeof dest)
{
    new Regex:r = Regex_New(regexp);

    if (r)
    {
        Regex_Replace(str, r, fmt, dest, MATCH_DEFAULT, size);
        Regex_Delete(r);
    }
}

stock RGBAToARGB(col)
{
    return ((((col) << 24) & 0xFF000000) | (((col) >>> 8) & 0xFFFFFF));
}

stock ARGBToRGBA(col)
{
    return ((((col) << 8) & 0xFFFFFF00) | (((col) >>> 24) & 0xFF));
}

bool:IsValidEmailAddress(const str[])
{
    static Regex:email_rgx;
    if(!email_rgx)
        email_rgx = Regex_New("^[\\w\\d.!#$%&'*+/=?^`{|}~-]+@[\\w\\d-]+\\.[\\w\\d-]{2,11}$", REGEX_ICASE);

    return bool:Regex_Check(str, email_rgx);
}

bool:Skin_IsFat(skin)
{
    switch(skin)
    {
        case 5: return true;
        case 149: return true;
        case 182: return true;
        case 241: return true;
        case 242: return true;
        case 264: return true;
        case 269: return true;
    }
    return false;
}

Vehicle_GetPaintjobs(modelid)
{
	switch(modelid)
	{
		case 483: return 1;
		case 534..536: return 3;
		case 558..562: return 3;
		case 565, 567: return 3;
		case 575: return 2;
		case 576: return 3;
	}
	return false;
}

Data_CheckValidity(Float:data)
{
	if (floatcmp(data, data) != 0 || floatcmp(data, Float:0x7F800000) == 0 || floatcmp(data, Float:0xFF800000) == 0)
        return 1;
	
    return 0;
}

Data_CheckOutputLimit(Float:data, Float:max, Float:min = 0.0, bool:check = false)
{
	if (floatcmp(floatabs(data), max) > 0 || check && floatcmp(data, min) < 0)
        return 1;
	
    return 0;
}