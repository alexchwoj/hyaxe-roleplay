#if defined _fixes_streamer_
    #endinput
#endif
#define _fixes_streamer_

native FIXED_Streamer_HasIntData(type, STREAMER_ALL_TAGS:id, data, ____do_not_change____ = 0) = Streamer_HasIntData;
#if defined _ALS_Streamer_HasIntData
    #undef Streamer_HasIntData
#else
    #define _ALS_Streamer_HasIntData
#endif
#define Streamer_HasIntData FIXED_Streamer_HasIntData

native FIXED_Streamer_RemoveIntData(type, STREAMER_ALL_TAGS:id, data, ____do_not_change____ = 0) = Streamer_RemoveIntData;
#if defined _ALS_Streamer_RemoveIntData
    #undef Streamer_RemoveIntData
#else
    #define _ALS_Streamer_RemoveIntData
#endif
#define Streamer_RemoveIntData FIXED_Streamer_RemoveIntData

native FIXED_Streamer_HasArrayData(type, STREAMER_ALL_TAGS:id, data, ____do_not_change____ = 0) = Streamer_HasArrayData;
#if defined _ALS_Streamer_HasArrayData
    #undef Streamer_HasArrayData
#else
    #define _ALS_Streamer_HasArrayData
#endif
#define Streamer_HasArrayData FIXED_Streamer_HasArrayData