#if defined _NOTIFICATION_HEADER_
    #endinput
#endif
#define _NOTIFICATION_HEADER_

const MAX_NOTIFICATIONS = 16;
const NOTIFICATION_TEXT_BEAT_DIFF = 4;

enum eNotificationData 
{
    bool:notificationActive,
    notificationFrameCount,
    notificationFrameTimer,
    PlayerText:notificationTextdraw[3],
    Float:notificationHeight
};

new 
    NOTIFICATION_DATA[MAX_PLAYERS][MAX_NOTIFICATIONS][eNotificationData],
    g_rgiTextProcessTimer[MAX_PLAYERS],
    g_rgiTextProcessTick[MAX_PLAYERS];

forward NOTIFICATION_ProcessText(playerid, time, alpha_min, alpha_max, bool:should_hide);