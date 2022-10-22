#if defined _halloween_functions_
    #endinput
#endif
#define _halloween_functions_

GenerateRandomPumpkins(amount, Float:x, Float:y, Float:z, Float:range)
{
    for(new i; i < amount; ++i)
    {
        //printf("%f %f %f", x, y, z);
        DroppedItem_Create(ITEM_PUMPKIN, 1, 0, x + RandomFloat(-range, range), y + RandomFloat(-range, range), z, 0, 0, .timeout = 300 + random(300));
    }
    return 1;
}

command pumpkin(playerid, const params[], "")
{
    new Float:x, Float:y, Float:z;
    GetPlayerPos(playerid, x, y, z);
    GenerateRandomPumpkins(10, x, y, z, 20.0);
    return 1;
}
flags:pumpkin(CMD_FLAG<RANK_LEVEL_MANAGER>)