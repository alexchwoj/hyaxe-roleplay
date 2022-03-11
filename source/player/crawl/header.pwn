#if defined _crawl_header_
    #endinput
#endif
#define _crawl_header_


enum eCrawlData
{
    e_iCrawlKeyTimer,
    bool:e_bCrawlAnim
};

new g_rgeCrawlData[MAX_PLAYERS + 1][eCrawlData];