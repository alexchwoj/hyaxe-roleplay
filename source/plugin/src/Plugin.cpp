#include "main.hpp"

bool Plugin::OnLoad()
{
	RegisterNative<&Script::n_GetTextDrawCharacterWidth>("GetTextDrawCharacterWidth");
	RegisterNative<&Script::n_GetTextDrawStringWidth>("GetTextDrawStringWidth");
	RegisterNative<&Script::n_GetTextDrawLineWidth>("GetTextDrawLineWidth");
	RegisterNative<&Script::n_GetTextDrawLineCount>("GetTextDrawLineCount");
	RegisterNative<&Script::n_SplitTextDrawString>("SplitTextDrawString");
	RegisterNative<&Script::n_memset>("memset");
	RegisterNative<&Script::n_RandomFloat>("RandomFloat");
	RegisterNative<&Script::n_levenshtein>("levenshtein");

	Log("Loaded");
	return true;
}