#if defined _enter_exits_header_
    #endinput
#endif
#define _enter_exits_header_

const HYAXE_MAX_ENTER_EXITS = 2048;

enum eEnterExit {
    bool:e_bValid,

    Float:e_fEnterX,
    Float:e_fEnterY,
    Float:e_fEnterZ,
    Float:e_fEnterAngle,
    e_iEnterWorld,
    e_iEnterInterior,
    e_iEnterPickup,
    Text3D:e_iEnterLabel,
    e_iEnterArea,
    
    Float:e_fExitX,
    Float:e_fExitY,
    Float:e_fExitZ,
    Float:e_fExitAngle,
    e_iExitWorld,
    e_iExitInterior,
    e_iExitPickup,
    Text3D:e_iExitLabel,
    e_iExitArea,

    e_iEnterExitData,
    e_iEnterExitCallback
};

new g_rgeEnterExits[HYAXE_MAX_ENTER_EXITS][eEnterExit];