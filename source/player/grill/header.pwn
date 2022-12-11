#if defined _grill_header_
    #endinput
#endif
#define _grill_header_

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