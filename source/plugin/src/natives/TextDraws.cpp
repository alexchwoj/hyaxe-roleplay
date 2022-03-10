#include "../main.hpp"

static constexpr std::array<std::uint8_t, 4> TDCharacterDefaultWidth{{ 
	27, 20, 27, 20 
}};

static constexpr std::array<std::array<std::uint8_t, 176>, 4> TDCharacterWidth {{
	{
		 0,  12,  12,  12,  12,  12,  12,  12,
		12,  12,  12,  12,  12,  12,  12,  12,
		12,  12,  12,  12,  12,  12,  12,  12,
		12,  12,  12,  12,  12,  12,  12,  12,
		12,  13,  13,  28,  28,  28,  28,   8,
		17,  17,  30,  28,  28,  12,   9,  21,
		28,  14,  28,  28,  28,  28,  28,  28,
		28,  28,  13,  13,  30,  30,  30,  30,
		10,  25,  23,  21,  24,  22,  20,  24,
		24,  17,  20,  22,  20,  30,  27,  27,
		26,  26,  24,  23,  24,  31,  23,  31,
		24,  23,  21,  28,  33,  33,  14,  28,
		10,  11,  12,   9,  11,  10,  10,  12,
		12,   7,   7,  13,   5,  18,  12,  10,
		12,  11,  10,  12,   8,  13,  13,  18,
		17,  13,  12,  30,  30,  37,  35,  37,
		25,  25,  25,  25,  33,  21,  24,  24,
		24,  24,  17,  17,  17,  17,  27,  27,
		27,  27,  31,  31,  31,  31,  11,  11,
		11,  11,  11,  20,   9,  10,  10,  10,
		10,   7,   7,   7,   7,  10,  10,  10,
		10,  13,  13,  13,  13,  27,  12,  30
	}, {
		 0,  15,  15,  15,  15,  15,  15,  15,
		15,  15,  15,  15,  15,  15,  15,  15,
		15,  15,  15,  15,  15,  15,  15,  15,
		15,  15,  15,  15,  15,  15,  15,  15,
		15,   9,  17,  27,  20,  34,  23,  12,
		12,  12,  21,  20,  12,  14,  12,  15,
		23,  15,  21,  21,  21,  21,  21,  21,
		20,  21,  12,  12,  24,  24,  24,  19,
		10,  22,  19,  19,  22,  16,  19,  24,
		22,  11,  16,  21,  15,  28,  24,  27,
		20,  25,  19,  19,  18,  23,  23,  31,
		23,  19,  21,  21,  13,  35,  11,  21,
		10,  19,  20,  14,  20,  19,  13,  20,
		19,   9,   9,  19,   9,  29,  19,  21,
		19,  19,  15,  15,  14,  18,  19,  27,
		20,  20,  17,  21,  17,  20,  15,  15,
		22,  22,  22,  22,  29,  19,  16,  16,
		16,  16,  11,  11,  11,  11,  27,  27,
		27,  27,  23,  23,  23,  23,  20,  19,
		19,  19,  19,  30,  14,  19,  19,  19,
		19,   9,   9,   9,   9,  21,  21,  21,
		21,  18,  18,  18,  18,  24,  19,  19
	}, {
		 0,  15,  23,  15,  21,  21,  21,  21,
		21,  21,  20,  21,  12,  12,  24,  24,
		24,  19,  10,  22,  19,  19,  22,  16,
		19,  24,  22,  11,  16,  21,  15,  28,
		12,  13,  13,  28,  37,  28,  30,   8,
		17,  17,  30,  28,  28,  12,   9,  21,
		27,  16,  27,  27,  27,  27,  27,  27,
		27,  27,  18,  13,  30,  30,  30,  30,
		10,  29,  26,  25,  28,  26,  25,  27,
		28,  12,  24,  25,  24,  30,  27,  29,
		26,  26,  25,  26,  25,  26,  28,  32,
		27,  26,  26,  28,  33,  33,  10,  28,
		10,  29,  26,  25,  28,  26,  25,  27,
		28,  12,  24,  25,  24,  30,  27,  29,
		26,  26,  25,  26,  25,  26,  28,  32,
		27,  26,  26,  30,  30,  37,  35,  37,
		29,  29,  29,  29,  33,  25,  26,  26,
		26,  26,  14,  14,  14,  14,  29,  29,
		29,  29,  26,  26,  26,  26,  21,  29,
		29,  29,  29,  33,  25,  26,  26,  26,
		26,  14,  14,  14,  14,  29,  29,  29,
		29,  26,  26,  26,  26,  25,  25,  30
	}, {
		 0,   9,   9,  18,  18,  18,  18,  18,
		18,  18,  18,  19,  19,  19,   0,   9,
		 9,   9,   9,  18,  18,  18,  18,  18,
		18,  18,  18,  19,  19,  19,   0,   9,
		15,  10,  17,  27,  20,  34,  23,  10,
		15,  15,  21,  20,  12,  14,   9,  15,
		20,  18,  19,  19,  21,  19,  19,  19,
		19,  19,  16,  12,  24,  24,  24,  21,
		10,  19,  19,  19,  20,  19,  16,  19,
		19,   9,  19,  20,  14,  29,  19,  19,
		19,  19,  19,  19,  21,  19,  20,  32,
		21,  19,  19,  21,  13,  35,  10,  21,
		10,  19,  19,  19,  20,  19,  16,  19,
		19,   9,  19,  20,  14,  29,  19,  19,
		19,  19,  19,  19,  21,  19,  20,  32,
		21,  19,  19,  21,  17,  20,  15,  15,
		19,  19,  19,  19,  29,  19,  19,  19,
		19,  19,   9,   9,   9,   9,  19,  19,
		19,  19,  19,  19,  19,  19,  19,  19,
		19,  19,  19,  29,  19,  19,  19,  19,
		19,   9,   9,   9,   9,  19,  19,  19,
		19,  19,  19,  19,  19,  21,  21,  19
	}
}};

static constexpr std::array<std::uint8_t, 32> TDFont3CharacterInlineWidth{{
	 0, 255,   0,   0, 128,  63, 147,  36,
	19,  64,   0,   0,   0,   0,   0,   0,
	32,  68,   0,   0,   0,   0,   0,   0,
	 0,   0,   0,   0,   0,   0,   0,   0
}};

cell Script::n_GetTextDrawCharacterWidth(int character, int font, int proportional)
{
	if ((font < 0 || font > 3) || (character < 0 || character > 176))
		return 0;

	if (!proportional || character >= TDCharacterWidth[0].size())
		return TDCharacterDefaultWidth[font];
	
	return TDCharacterWidth[font][character];
}

cell Script::n_GetTextDrawStringWidth(std::string string, int font, int outline, int proportional)
{
	int other{ 0 }, result{ 0 }, width{ 0 };

	for (size_t i{ 0 }, length = string.length(); i < length; ++i)
	{
		if (string[i] == '~')
		{
			if ((other = string.find('~', i + 1)) == std::string::npos)
			{
				return -1;
			}

			if (other == i + 2 && string[i + 1] == 'n')
			{
				if (result < width)
				{
					result = width;
				}

				width = 0;
			}

			i = other + 1;
		}
		else
		{
			if (font == 3 && (string[i] > 0 && string[i] < 32) && i != length - 1 && (string.find("~n~", i + 1) != i + 1))
			{
				width += TDFont3CharacterInlineWidth[string[i]];
			}
			else
			{
				width += n_GetTextDrawCharacterWidth(string[i], font, proportional);
			}
		}
	}

	if (result < width)
		result = width;

	return result + (outline * 2);
}

cell Script::n_GetTextDrawLineWidth(std::string string, int font, int outline, int proportional, int start, int end)
{
	int other{ 0 }, width{ 0 };

	if (end == -1)
		end = string.length();

	for (; start < end; ++start)
	{
		if (string[start] == '~')
		{
			if ((other = string.find('~', start + 1)) == std::string::npos)
			{
				return -1;
			}

			start = other + 1;
		}
		else
		{
			if (font == 3 && (string[start] > 0 && string[start] < 32) && start != end - 1)
			{
				width += TDFont3CharacterInlineWidth[string[start]];
			}
			else
			{
				width += n_GetTextDrawCharacterWidth(string[start], font, proportional);
			}
		}
	}

	return width + (outline * 2);
}

cell Script::n_GetTextDrawLineCount(std::string string)
{
	int count{ 1 }, pos{ -3 };

	while ((pos = string.find("~n~", pos + 3)) != std::string::npos)
	{
		++count;
	}

	return count;
}

cell Script::n_SplitTextDrawString(cell* string_ptr, float max_width, float letter_size, int font, int outline, int proportional, int size)
{
	int amx_str_len{ 0 };
	GetAmx()->StrLen(string_ptr, &amx_str_len);

	if (!amx_str_len)
		return false;

	++amx_str_len;

	std::string string;
	string.resize(amx_str_len);

	GetAmx()->GetString(string.data(), string_ptr, 0, amx_str_len);

	int other{ 0 }, line_start{ 0 }, previous_space{ -1 }, length{ static_cast<int>(string.length()) };

	const auto SplitTryToReplace = [this](std::string& string, float max_width, float letter_size, int font, int outline, int proportional, int line_start, int previous_space, int size, int pos, int length)
	{
		if (letter_size * n_GetTextDrawLineWidth(string, font, outline, proportional, line_start, pos) <= max_width)
			return 0;

		if (previous_space != -1)
		{
			if (length + 2 < size)
			{
				string.erase(previous_space, 1);
				string.insert(previous_space, "~n~");
				return 1;
			}

			return -1;
		}

		return 0;
	};

	for (int i{ 0 }; i < length;)
	{
		switch (string[i])
		{
			case '~':
			{
				if ((other = string.find('~', i + 1)) == std::string::npos)
					return false;

				if (other == i + 2 && string[i + 1] == 'n')
				{
					switch (SplitTryToReplace(string, max_width, letter_size, font, outline, proportional, line_start, previous_space, size, i, length))
					{
						case -1:
						{
							return true;
						}
						case 1:
						{
							i += 5;
							length += 2;
							previous_space = -1;
							break;
						}
						case 0:
						{
							i += 3;
							break;
						}
					}

					line_start = i;
				}
				else
				{
					i = other + 1;
				}

				break;
			}
			case ' ':
			{
				switch (SplitTryToReplace(string, max_width, letter_size, font, outline, proportional, line_start, previous_space, size, i, length))
				{
					case -1:
					{
						return true;
					}
					case 1:
					{
						i += 3;
						length += 2;
						line_start = previous_space + 3;
						previous_space = i - 1;
						break;
					}
					case 0:
					{
						previous_space = i;
						i++;
						break;
					}
				}

				break;
			}

			default:
			{
				i++;
				break;
			}
		}
	}

	SplitTryToReplace(string, max_width, letter_size, font, outline, proportional, line_start, previous_space, size, length, length);

	SetString(string_ptr, string, size);

	return true;
}