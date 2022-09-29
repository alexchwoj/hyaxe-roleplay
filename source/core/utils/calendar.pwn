#if defined _utils_calendar_
    #endinput
#endif
#define _utils_calendar_

stock Calendar_GetWeekDay(year, month, day)
{
	return (day += month < 3 ? year-- : year - 2, 23 * month / 9 + day + 4 + year / 4 - year / 100 + year / 400) % 7;
}

#define MAX_WEEKDAY_NAME 9
#define MAX_WEEKDAY_SHORT_NAME 3
static const g_szWeekdayNames[][2][] = {
	{"Domingo", "DO"},
	{"Lunes", "LU"},
	{"Martes", "MA"},
	{"Miércoles", "MI"},
	{"Jueves", "JU"},
	{"Viernes", "VI"},
	{"Sábado", "SA"}
};

stock Calendar_GetWeekdayName(weekday, name[], len = sizeof(name))
{
	if (weekday >= 0 && weekday <= 6)
		return strmid(name, g_szWeekdayNames[weekday][0], 0, len, len);

	return 0;
}

stock Calendar_GetWeekdayShortName(weekday, name[], len = sizeof(name))
{
	if (weekday >= 0 && weekday <= 6)
		return strmid(name, g_szWeekdayNames[weekday][1], 0, len, len);

	return 0;
}

#define MAX_MONTH_NAME 9
#define MAX_MONTH_SHORT_NAME 3
static const g_szMonthNames[][2][] = {
	{"Enero", "ENE"},
	{"Febrero", "FEB"},
	{"Marzo", "MAR"},
	{"Abril", "ABR"},
	{"Mayo", "MAY"},
	{"Junio", "JUN"},
	{"Julio", "JUL"},
	{"Agosto", "AGO"},
	{"Septiembre", "SEP"},
	{"Octubre", "OCT"},
	{"Noviembre", "NOV"},
	{"Diciembre", "DIC"}
};

stock Calendar_GetMonthName(month, name[], len = sizeof(name))
{
	if (month >= 1 && month <= 12)
	    return strmid(name, g_szMonthNames[month - 1][0], 0, len, len);

	return 0;
}

stock Calendar_GetMonthShortName(month, name[], len = sizeof(name))
{
	if (month >= 1 && month <= 12)
        return strmid(name, g_szMonthNames[month - 1][1], 0, len, len);

	return 0;
}