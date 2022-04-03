#if defined _detections_money_
    #endinput
#endif
#define _detections_money_

const __ac_money_StatsUpdate = 205;
IPacket:__ac_money_StatsUpdate(playerid, BitStream:bs)
{
    new money;
    BS_ReadValue(bs,
        PR_IGNORE_BITS, 8,
        PR_INT32, money
    );

    if(money != Player_Money(playerid))
    {
        ResetPlayerMoney(playerid);
        GivePlayerMoney(playerid, Player_Money(playerid));

        BS_SetWriteOffset(bs, 8);
        BS_WriteValue(bs, 
            PR_INT32, Player_Money(playerid)
        );
    }

    return 1;
}