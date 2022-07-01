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
#if !NDEBUG
    PrintBacktrace();
#endif

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

stock Str_FixEncoding_s(String:result)
{
	for (new i = (str_len(result) - 1); i != -1; --i)
    {
        switch (str_getc(result, i))
        {
            case 'á': str_setc(result, i, 152);
            case 'â': str_setc(result, i, 153);
            case 'ä': str_setc(result, i, 154);
            case 'À': str_setc(result, i, 128);
            case 'Á': str_setc(result, i, 129);
            case 'Â': str_setc(result, i, 130);
            case 'Ä': str_setc(result, i, 131);
            case 'è': str_setc(result, i, 157);
            case 'é': str_setc(result, i, 158);
            case 'ê': str_setc(result, i, 159);
            case 'ë': str_setc(result, i, 160);
            case 'È': str_setc(result, i, 134);
            case 'É': str_setc(result, i, 135);
            case 'Ê': str_setc(result, i, 136);
            case 'Ë': str_setc(result, i, 137);
            case 'ì': str_setc(result, i, 161);
            case 'í': str_setc(result, i, 162);
            case 'î': str_setc(result, i, 163);
            case 'ï': str_setc(result, i, 164);
            case 'Ì': str_setc(result, i, 138);
            case 'Í': str_setc(result, i, 139);
            case 'Î': str_setc(result, i, 140);
            case 'Ï': str_setc(result, i, 141);
            case 'ò': str_setc(result, i, 165);
            case 'ó': str_setc(result, i, 166);
            case 'ô': str_setc(result, i, 167);
            case 'ö': str_setc(result, i, 168);
            case 'Ò': str_setc(result, i, 142);
            case 'Ó': str_setc(result, i, 143);
            case 'Ô': str_setc(result, i, 144);
            case 'Ö': str_setc(result, i, 145);
            case 'ù': str_setc(result, i, 169);
            case 'ú': str_setc(result, i, 170);
            case 'û': str_setc(result, i, 171);
            case 'ü': str_setc(result, i, 172);
            case 'Ù': str_setc(result, i, 146);
            case 'Ú': str_setc(result, i, 147);
            case 'Û': str_setc(result, i, 148);
            case 'Ü': str_setc(result, i, 149);
            case 'ñ': str_setc(result, i, 174);
            case 'Ñ': str_setc(result, i, 173);
            case '¡': str_setc(result, i, 64);
            case '¿': str_setc(result, i, 175);
            case '`': str_setc(result, i, 177);
            case '&': str_setc(result, i, 38);
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
	format(str, sizeof(str), "%i de %s del %i", day, month_names[month], year);
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

String:Str_Random(len)
{
    new String:s = str_new_buf(len + 1);
    
    for(new i = len; i != -1; --i)
    {
        str_setc(s, i, random(2) ? (random(26) + (random(2) ? 'a' : 'A')) : (random(10) + '0'));
    }

    return s;
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

List:GetPlayerAllDynamicAreas(playerid)
{
    static areas[128];
    new count = GetPlayerDynamicAreas(playerid, areas);
    return list_new_arr(areas, count);
}

static enum eLoggerVarData
{
    String:e_sVarName,
    bool:e_bReference,
    bool:e_bArray,
    e_iTagId,
    e_aValue // a[ny]
};

#if NDEBUG
    #define log_function();
#else
    // For some reason, debug_func using the return address doesn't work. Silly workaround

    #define log_function() log_function__(debug_func(), (_:__emit(lctrl 5)))

    log_function__(Symbol:fun, prev_fun_frm)
    {
        if(fun == INVALID_SYMBOL_ID)
            return 0;

        new String:fun_name = debug_symbol_name_s(fun);

        new vars[32][eLoggerVarData], varcount;
        new Iter:fun_vars = debug_symbol_variables(fun);
        iter_to_last(fun_vars);

        for(new i = 0, j = GetFrameParameterCount(prev_fun_frm); i < j && iter_inside(fun_vars); ++i, iter_move_previous(fun_vars))
        {
            new Symbol:sym = Symbol:iter_get(fun_vars);
        
            new val = GetFrameParameter(prev_fun_frm, i);
            new symbol_kind:type = debug_symbol_kind(sym);
            new tag = debug_symbol_tag(sym);
            
            if(type == symbol_kind_reference || type == symbol_kind_array_reference)
            {
                vars[i][e_bReference] = true;
            }

            if(type == symbol_kind_array || type == symbol_kind_array_reference)
            {
                vars[i][e_bArray] = true;
            }

            vars[i][e_iTagId] = (tag == cellmin ? (tagof(_:)) : tag);
            vars[i][e_aValue] = val;
            vars[i][e_sVarName] = debug_symbol_name_s(sym);
            varcount++;
        }

        iter_delete(fun_vars);

        new String:full_line = @f("[log] %S(", fun_name);

        for(new i; i < varcount; ++i)
        {
            new String:varname = vars[i][e_sVarName];

            if(vars[i][e_bReference] && !vars[i][e_bArray])
            {
                str_append(full_line, @("&"));
            }

            new tagname[32];
            tag_name(tag_uid(vars[i][e_iTagId]), tagname);
            if(tagname[0] && tagname[0] != '_')
            {
                full_line += @f("%s:", tagname);
            }

            if(vars[i][e_bArray])
            {
                full_line += @f("%s%S[], ", (vars[i][e_bReference] ? "" : "const "), varname);
            }
            else
            {
                full_line += @f("%S = ", varname);

                if(vars[i][e_bReference])
                {
                    full_line += @f("[0x%x] -> ", vars[i][e_aValue]);
                }

                new value = vars[i][e_aValue];
                if(vars[i][e_bReference])
                {
                    new dummy[1];
                    dummy = deref(value);
                    value = dummy[0];
                }

                full_line += @f("{0:P}, ", pawn_arg_pack(value, vars[i][e_iTagId]));
            }

            str_delete(varname);
        }

        if(varcount)
        {
            str_del(full_line, str_len(full_line) - 2);
        }

        full_line += @(");");

        print_s(full_line);

        str_delete(full_line);

        return 1;
    }
#endif

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