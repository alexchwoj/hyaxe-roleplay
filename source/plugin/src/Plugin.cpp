#include "main.hpp"

bool Plugin::OnLoad()
{
	RegisterNative<&Script::n_GetTextDrawCharacterWidth>("GetTextDrawCharacterWidth");
	RegisterNative<&Script::n_GetTextDrawStringWidth>("GetTextDrawStringWidth");
	RegisterNative<&Script::n_GetTextDrawLineWidth>("GetTextDrawLineWidth");
	RegisterNative<&Script::n_GetTextDrawLineCount>("GetTextDrawLineCount");
	RegisterNative<&Script::n_SplitTextDrawString>("SplitTextDrawString");
	RegisterNative<&Script::n_levenshtein>("levenshtein");
	RegisterNative<&Script::n_argon_hash, false>("argon_hash");
	RegisterNative<&Script::n_argon_check, false>("argon_check");
	RegisterNative<&Script::n_argon_set_thread_count>("argon_set_thread_count");
	RegisterNative<&Script::n_argon_get_hash, false>("argon_get_hash");
	RegisterNative<&Script::n_argon_is_equal>("argon_is_equal");

	Log("Loaded");
	return true;
}

void Plugin::OnProcessTick()
{
	EveryScript([](const std::shared_ptr<Script>& script) -> bool {
		script->ProcessResultQueue();
		script->ProcessWorkQueue();
		return true;
	});
}