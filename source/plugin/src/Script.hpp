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

	cell n_levenshtein(std::string s1, std::string s2);

	cell n_argon_hash(cell* params);
	cell n_argon_check(cell* params);
	cell n_argon_set_thread_count(int max_threads);
	cell n_argon_get_hash(cell* params);
	cell n_argon_is_equal();

	void ProcessWorkQueue();
	void ProcessResultQueue();
private:
	sf::contfree_safe_ptr<std::queue<std::unique_ptr<ArgonWork>>> _work_queue;
	sf::contfree_safe_ptr<std::queue<std::unique_ptr<ArgonWork>>> _result_queue;
	std::atomic<std::uint8_t> _max_worker_threads{ 3 };
	std::atomic<std::uint8_t> _active_threads{ 0 };
};