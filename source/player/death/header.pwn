#if defined _death_header_
    #endinput
#endif
#define _death_header_


enum eCrawlData
{
    e_iCrawlKeyTimer,
    bool:e_bCrawlAnim
};

new g_rgeCrawlData[MAX_PLAYERS + 1][eCrawlData];