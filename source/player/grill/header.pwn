#if defined _grill_header_
    #endinput
#endif
#define _grill_header_

const HYAXE_MAX_GRILLS = 16;

enum eGrillData
{
    bool:e_bValid,
    e_iOwnerID,

    e_iArea,
    Text3D:e_i3DLabel,

    e_iBBQObject,
    e_iContentObject,
    e_iSmokeObject,

    bool:e_bCooking
};

new g_rgeGrills[HYAXE_MAX_GRILLS][eGrillData];