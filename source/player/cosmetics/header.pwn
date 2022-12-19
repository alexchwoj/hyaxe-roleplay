#if defined _cosmetics_header_
    #endinput
#endif
#define _cosmetics_header_

const HYAXE_MAX_COSMETICS = 12;

enum _:eCosmeticType
{
    COSMETIC_TYPE_NONE,
    COSMETIC_TYPE_HAT,
    COSMETIC_TYPE_GLASSES,
    COSMETIC_TYPE_WATCH,
    COSMETIC_TYPE_MASK
};

enum eCosmeticOffsets
{
    e_iBone,
    Float:e_fPosX,
    Float:e_fPosY,
    Float:e_fPosZ,

    Float:e_fRotX,
    Float:e_fRotY,
    Float:e_fRotZ,

    Float:e_fScaleX,
    Float:e_fScaleY,
    Float:e_fScaleZ
};

new g_rgeCosmeticsOffsets[eCosmeticType][eCosmeticOffsets] = {
    {0, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, 1.0000, 1.0000, 1.0000}, // COSMETIC_TYPE_NONE
    {2, 0.1349, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, 1.0000, 1.0000, 1.0000}, // COSMETIC_TYPE_HAT
    {2, 0.0990, 0.0250, -0.0020, 82.2000, 89.0000, 7.8999, 1.0000, 1.0000, 1.0000}, // COSMETIC_TYPE_GLASSES
    {6, 0.0000, -0.0080, -0.0039, 139.3997, -80.9999, 6.8999, 1.0000, 1.0000, 1.0000}, // COSMETIC_TYPE_WATCH
    {2, 0.0759, 0.0290, -0.0039, -87.5000, -6.0999, -89.0000, 0.9410, 1.0000, 0.9320} // COSMETIC_TYPE_MASK
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