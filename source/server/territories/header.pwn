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
	Float:e_fConquestProgress,
	e_iConquestTimer,
	e_iGangAttacking,

	e_iArea,
	e_iGangZone,
    e_iColor,
	e_iGangID,

	e_iFlagObject,
	Text3D:e_iLabel,
	e_iMapIcon
};
new g_rgeTerritories[HYAXE_MAX_TERRITORIES][eTerritoryInfo];