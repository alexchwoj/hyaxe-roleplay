#if defined _interop_header_
    #endinput
#endif
#define _interop_header_

native GetTextDrawCharacterWidth(character, font, bool:proportional = true);
native GetTextDrawStringWidth(const string[], font, outline = 0, bool:proportional = true);
native GetTextDrawLineWidth(const string[], font, outline = 0, bool:proportional = true, start = 0, end = -1);
native GetTextDrawLineCount(const string[]);
native bool:SplitTextDrawString(string[], Float:max_width, Float:letter_size, font, outline = 0, bool:proportional = true, size = sizeof(string));
native memset(arr[], val, size = sizeof(arr));