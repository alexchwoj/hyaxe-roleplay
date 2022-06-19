#if defined _detections_fly_
    #endinput
#endif
#define _detections_fly_

const __ac_fly_PlayerSync = 207;
IPacket:__ac_fly_PlayerSync(playerid, BitStream:bs)
{
    if (Player_HasImmunityForCheat(playerid, CHEAT_FLY))
        return 1;

    new onFootData[PR_OnFootSync];

    BS_IgnoreBits(bs, 8);
    BS_ReadOnFootSync(bs, onFootData);

    new diff = GetTickDiff(GetTickCount(), g_rgePlayerTempData[playerid][e_iPlayerFootTick]);
    if (diff >= 15000)
    {
        switch(onFootData[PR_animationId])
        {
            case 157, 159, 161:
            {
                if (!IsPlayerInAnyVehicle(playerid))
                {
                    Anticheat_Trigger(playerid, CHEAT_FLY);
                    return 0;
                }
            }
            case 958, 959:
            {
                if (onFootData[PR_weaponId] != WEAPON_PARACHUTE)
                {
                    Anticheat_Trigger(playerid, CHEAT_FLY);
                    return 0;
                }
            }
            case 1538, 1539, 1543:
            {
                new Float:depth, Float:playerdepth;
                if (!CA_IsPlayerInWater(playerid, depth, playerdepth))
                {
                    if (onFootData[PR_position][2] > 1.0)
                    {
                        Anticheat_Trigger(playerid, CHEAT_FLY);
                        return 0;
                    }
                }
            }
        }

        g_rgePlayerTempData[playerid][e_iPlayerFootTick] = GetTickCount();
    }
    return 1;
}