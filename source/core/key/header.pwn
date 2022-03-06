#if defined _KEY_HEADER_
    #endinput
#endif
#define _KEY_HEADER_

enum eKeyInfo {
    bool:e_bKeyActived,
    bool:e_bKeyGoingUp,
    e_iKeyFrameCount,
    e_iKeyTimer
}

new g_rgeKeyData[MAX_PLAYERS + 1][eKeyInfo];