#if defined _boombox_header_
    #endinput
#endif
#define _boombox_header_

enum eBoomboxData
{
    e_iBoomboxOwnerId,
    e_iBoomboxObjectId,
    Text3D:e_iBoomboxLabelId,
    Float:e_fBoomboxVolume,
    bool:e_bBoomboxIsPublic,
    bool:e_bBoomboxPlayingFor[MAX_PLAYERS]
};

#define STEREO_API_ENDPOINT(%0) "ws.hyaxe.com"%0