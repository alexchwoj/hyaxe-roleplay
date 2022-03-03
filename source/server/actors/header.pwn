#if defined _actors_header_
    #endinput
#endif
#define _actors_header_

const MAX_ROBBABLE_ACTORS = 20;

enum eRobbableActor
{
    bool:e_bValid,
    e_iActorId,
    e_iLastStealTick,
    e_iMinMoneyReward,
    e_iMaxMoneyReward,

    e_iRobbingPlayer,
    e_iRobberyTimer
};

new g_rgeRobbableActors[MAX_ROBBABLE_ACTORS][eRobbableActor];

forward Actor_CreateRobbable(model, min_money, max_money, Float:x, Float:y, Float:z, Float:angle, worldid = -1, interiorid = -1);
forward Actor_Rob(playerid, actorid);

forward ROBBERY_Progress(playerid, actorid, phase);