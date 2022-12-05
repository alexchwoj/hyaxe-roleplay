#if defined _safe_zones_header_
    #endinput
#endif
#define _safe_zones_header_

enum eSafeZones
{
    Float:e_fZoneX,
    Float:e_fZoneY,
    Float:e_fZoneZ,
    Float:e_fRange,
    e_iWorld,
    e_iInterior
};

new const g_rgeSafeZones[][eSafeZones] = {
    { 90.8022, -270.4298, 1.5781, 100.0, 0, 0 }, // Trucker job
    { 2141.2632, -83.3317, 2.8640, 40.0, 0, 0 }, // Fisher job
    { 1552.6616, -1675.3116, 16.1953, 50.0, 0, 0 }, // LSPD
    { 1480.8910, -1770.4404, 18.7958, 30.0, 0, 0 }, // Townhall exterior
    { -2090.4871, 447.6155, 2982.7620, 50.0, 0, 0 }, // Townhall interior
    { 1174.0958, -1323.4114, 14.9922, 50.0, 0, 0 }, // Hospital (central)
    { 1728.6899, -1174.5288, 23.8307, 50.0, 0, 0 }, // Spawn
    { 2030.9231, -1412.9353, 16.9989, 50.0, 0, 0 }, // Hospital (jefferson)
    { 1976.0543, -1924.4429, 13.5469, 10.0, 0, 0 }, // Weapon job
    { 2447.2161, -1971.9438, 13.5469, 30.0, 0, 0 } // Black market
};