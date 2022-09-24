#if defined _detections_slapper_
    #endinput
#endif
#define _detections_slapper_

const __ac_slap_PlayerSync = 207;
IPacket:__ac_slap_PlayerSync(playerid, BitStream:bs)
{
    if (Player_HasImmunityForCheat(playerid, CHEAT_SLAPPER))
        return 1;

    new
        animation_id,
        animation_flags;

    BS_ReadValue(bs,
        PR_IGNORE_BITS, 8 + 16 + 16 + 16 + (32 * 7) + 8 + 8 + 2 + 6 + 8 + (32 * 6) + 16,
        PR_INT16, animation_id,
        PR_INT16, animation_flags
    );

    // anim slapper: WAYFARER:WF_BACK
    // source: https://gitlab.com/RcKoid/mod-s0beit-overlight/-/blob/master/src/OverLight_Funcs.cpp#L1734-1735
    // no wayfarer animation should play onfoot?
    if (animation_id == 1666 && animation_flags == 4356)
    {
        Anticheat_Trigger(playerid, CHEAT_SLAPPER);
        return 0;
    }

    return 1;
}