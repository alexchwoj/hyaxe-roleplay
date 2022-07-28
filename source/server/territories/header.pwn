#if defined _territories_header_
    #endinput
#endif
#define _territories_header_

const HYAXE_MAX_TERRITORIES = 512;
enum eTerritoryInfo
{
	bool:e_bValid,
	e_iID,
	e_szName[32],

	Float:e_fMinX,
	Float:e_fMinY,
	Float:e_fMinZ,
	Float:e_fMaxX,
	Float:e_fMaxY,
	Float:e_fMaxZ,

    bool:e_bIsConquerable,

	e_iArea,
	e_iGangZone,
    e_iColor
};
new g_rgeTerritories[HYAXE_MAX_TERRITORIES][eTerritoryInfo];