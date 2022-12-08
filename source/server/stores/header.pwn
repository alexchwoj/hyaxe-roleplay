#if defined _stores_header_
    #endinput
#endif
#define _stores_header_

const HYAXE_MAX_SHOPS = 25;
const HYAXE_MAX_SHOP_ITEMS = 10;

enum eShop
{
    bool:e_bShopValid,
    e_iShopItemAmount,
    Text3D:e_iShopLabel,
    e_iShopArea,

    e_szShopName[24],
    Float:e_fShopX,
    Float:e_fShopY,
    Float:e_fShopZ,
    e_iShopWorld,
    e_iShopInterior,

    Float:e_fShopCamX,
    Float:e_fShopCamY,
    Float:e_fShopCamZ,
    Float:e_fShopCamLookX,
    Float:e_fShopCamLookY,
    Float:e_fShopCamLookZ,

    Float:e_fShopObjectStartX,
    Float:e_fShopObjectStartY,
    Float:e_fShopObjectStartZ,
    Float:e_fShopObjectIdleX,
    Float:e_fShopObjectIdleY,
    Float:e_fShopObjectIdleZ,
    Float:e_fShopObjectEndX,
    Float:e_fShopObjectEndY,
    Float:e_fShopObjectEndZ,

    e_iShopCallback
};

new g_rgeShops[HYAXE_MAX_SHOPS][eShop];

enum eShopItem
{
    e_szItemName[48],
    e_iItemModel,
    e_iItemPrice,
    Float:e_fRotX,
    Float:e_fRotY,
    Float:e_fRotZ
};

new g_rgeShopItems[HYAXE_MAX_SHOPS][HYAXE_MAX_SHOP_ITEMS][eShopItem];

new
    g_rgiPlayerCurrentShop[MAX_PLAYERS char] = { 0xFFFFFFFF, ...} , // Make upacked when we eventually hit more than 255 stores
    g_rgiPlayerCurrentShopItem[MAX_PLAYERS char],
    g_rgiPlayerWaitingObjectMove[MAX_PLAYERS char],
    g_rgiPlayerShopObject[MAX_PLAYERS] = { INVALID_OBJECT_ID, ... };

forward Shop_Create(const name[], Float:pos_x, Float:pos_y, Float:pos_z, world, interior, Float:cam_x, Float:cam_y, Float:cam_z, Float:cam_look_x, Float:cam_look_y, Float:cam_look_z, Float:object_start_x, Float:object_start_y, Float:object_start_z, Float:object_idle_x, Float:object_idle_y, Float:object_idle_z, Float:object_end_x, Float:object_end_y, Float:object_end_z, buy_callback);
forward Shop_AddItem(shop_id, const name[], model, price, Float:rx, Float:ry, Float:rz);
forward Player_StopShopping(playerid);
