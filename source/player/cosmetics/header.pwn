#if defined _cosmetics_header_
    #endinput
#endif
#define _cosmetics_header_

const HYAXE_MAX_COSMETICS = 8;

enum _:eCosmeticType
{
    COSMETIC_TYPE_NONE,
    COSMETIC_TYPE_HAT,
    COSMETIC_TYPE_GLASSES,
    COSMETIC_TYPE_WATCH,
    COSMETIC_TYPE_MASK
};

enum eCosmeticData 
{
    bool:e_bValid,
    e_iID,
    e_iModelID,
    e_szName[32],

    Float:e_fPosX,
    Float:e_fPosY,
    Float:e_fPosZ,

    Float:e_fRotX,
    Float:e_fRotY,
    Float:e_fRotZ,

    Float:e_fScaleX,
    Float:e_fScaleY,
    Float:e_fScaleZ,

    e_iMaterialColorOne,
    e_iMaterialColorTwo,
    e_iType,
    e_iBone,
    bool:e_bPlaced,
    e_iAttachedObjectSlot
};

new
    g_rgePlayerCosmetics[MAX_PLAYERS + 1][HYAXE_MAX_COSMETICS][eCosmeticData],
    g_rgiCosmeticsSlots[MAX_PLAYERS][6]
;