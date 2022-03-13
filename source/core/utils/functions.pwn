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

stock InterpolateColourLinear(startColour, endColour, Float:fraction = Float:0x7FFFFFFF)
{
	new a = startColour & 0xFF;
	if (IsNaN(fraction))
	{
		// Extract the fraction from the second alpha.
		fraction = (endColour & 0xFF) / 255.0;
		// Use the first alpha for output transparency.
	}
	else
	{
		// Combine the alpha values to give a relative fraction and a final alpha.
		a = _:((a / 255.0) * (1.0 - fraction)),
		fraction = ((endColour & 0xFF) / 255.0) * fraction,

		// The final fraction is given comes from the relative ratio of the two alphas.
		a = _:(Float:a + fraction),
		fraction = fraction / Float:a,

		// The final alpha comes from their sum, as a fraction of 1.
		a = floatround(Float:a * 255.0);
	}
	if (fraction >= 1.0)
	{
		return endColour;
	}
    if (fraction <= 0.0)
	{
		return startColour;
	}
	new
		// Step 1: Get the starting colour components.
		r = startColour & 0xFF000000,
		g = startColour & 0x00FF0000,
		b = startColour & 0x0000FF00,
		// Manipulate the format of floats to multiply by 256 by increasing the exponent by 8.
		stage = floatround(Float:(_:fraction + 0x04000000)); // fraction * 256.0
	return
		// Step 2: Interpolate between the end points, and add to the start.
		// Step 3: Combine the individual components.
		(((r >>> 16) + ((endColour >>> 24       ) - (r >>> 24)) * stage) << 16 & 0xFF000000) |
		(((g >>>  8) + ((endColour >>> 16 & 0xFF) - (g >>> 16)) * stage) <<  8 & 0x00FF0000) |
		(((b       ) + ((endColour >>>  8 & 0xFF) - (b >>>  8)) * stage)       & 0x0000FF00) |
		(a & 0xFF);
	// Because we use a base of 256 instead of 100 to multiply the fractions, we would adjust the
	// numbers down via `>>> 8` instead of `/ 100`, but since we then shift them up again to their
	// final locations in the number we can skip a manipulation stage.
}