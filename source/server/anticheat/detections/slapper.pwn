#if defined _detections_slapper_
    #endinput
#endif
#define _detections_slapper_

const __ac_slap_PlayerSync = 207;
IPacket:__ac_slap_PlayerSync(playerid, BitStream:bs)
{
    if (Player_HasImmunityForCheat(playerid, CHEAT_SLAPPER))
        return 1;

    new data[PR_OnFootSync];
    BS_IgnoreBits(bs, 8);
    BS_ReadOnFootSync(bs, data);

    // anim slapper: WAYFARER:WF_BACK
    // source: https://gitlab.com/RcKoid/mod-s0beit-overlight/-/blob/master/src/OverLight_Funcs.cpp#L1734-1735
    // no wayfarer animation should play onfoot?
    if (data[PR_animationId] == 1666 && data[PR_animationFlags] == 4356)
    {
        Anticheat_Trigger(playerid, CHEAT_SLAPPER);
        return 0;
    }

    return 1;
}