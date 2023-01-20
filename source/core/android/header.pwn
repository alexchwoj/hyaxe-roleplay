#if defined _android_header_
    #endinput
#endif
#define _android_header_

new
    bool:g_rgbIsAndroid[MAX_PLAYERS char];
    
#define Player_IsAndroid(%0) (g_rgbIsAndroid{(%0)})