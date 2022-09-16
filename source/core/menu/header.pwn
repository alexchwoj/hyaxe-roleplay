#if defined _menu_header_
    #endinput
#endif
#define _menu_header_

#if !defined MENU_SOUND_UPDOWN
	#define MENU_SOUND_UPDOWN \
		1054
#endif

#if !defined MENU_SOUND_CLOSE
	#define MENU_SOUND_CLOSE \
		1084
#endif

#if !defined MENU_SOUND_SELECT
	#define MENU_SOUND_SELECT \
		1083
#endif

#if !defined MENU_MAX_LISTITEMS
	#define MENU_MAX_LISTITEMS \
		24
#endif

#if !defined MENU_MAX_LISTITEM_SIZE
	#define MENU_MAX_LISTITEM_SIZE \
		128
#endif

#if !defined MENU_MAX_LISTITEMS_PERPAGE
	#define MENU_MAX_LISTITEMS_PERPAGE \
		8
#endif

#define MENU_COUNT_PAGES(%0,%1) \
	(((%0) - 1) / (%1) + 1)

#define MENU:%0(%1) \
	forward menu_%0(%1); public menu_%0(%1)

#define Menu:%0(%1) \
	MENU:%0(%1)

enum
{
	MENU_RESPONSE_UP,
	MENU_RESPONSE_DOWN,
	MENU_RESPONSE_SELECT,
	MENU_RESPONSE_CLOSE
};

enum E_PLAYER_MENU
{
	E_PLAYER_MENU_ID[32],
    E_PLAYER_MENU_PAGE,
    E_PLAYER_MENU_LISTITEM,
    E_PLAYER_MENU_TOTAL_LISTITEMS,
	E_PLAYER_MENU_TICKCOUNT
};
new playerMenu[MAX_PLAYERS][E_PLAYER_MENU];

enum E_MENU_TEXTDRAW
{
	E_MENU_TEXTDRAW_LISTITEM_COUNT,
	E_MENU_TEXTDRAW_LISTITEMS[MENU_MAX_LISTITEMS_PERPAGE],
	E_MENU_TEXTDRAW_INFO_BOX,
	E_MENU_TEXTDRAW_INFO_ICON,
	E_MENU_TEXTDRAW_INFO_TEXT,
};
new menuPlayerTextDrawsID[MAX_PLAYERS][E_MENU_TEXTDRAW];
new PlayerText:menuPlayerTextDraws[MAX_PLAYERS][50];
new menuPlayerTextDrawsCount[MAX_PLAYERS];

new playerMenuListitems[MAX_PLAYERS][MENU_MAX_LISTITEMS][MENU_MAX_LISTITEM_SIZE char];
new playerMenuListitemsInfo[MAX_PLAYERS][MENU_MAX_LISTITEMS][MENU_MAX_LISTITEM_SIZE char];