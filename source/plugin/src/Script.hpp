#pragma once

class Script : public ptl::AbstractScript<Script>
{
public:
	const char* VarIsGamemode() { return "__HYAXE__"; }

	cell n_SplitTextDrawString(cell* string_ptr, float max_width, float letter_size, int font, int outline, int proportional, int size);
	cell n_GetTextDrawLineCount(std::string string);
	cell n_GetTextDrawLineWidth(std::string string, int font, int outline, int proportional, int start, int end);
	cell n_GetTextDrawStringWidth(std::string string, int font, int outline, int proportional);
	cell n_GetTextDrawCharacterWidth(int character, int font, int proportional);

	cell n_memset(cell arr, int value, int cell_count);
	cell n_RandomFloat(float min, float max);
	cell n_levenshtein(std::string s1, std::string s2);
};