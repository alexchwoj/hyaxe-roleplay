#pragma once

class Plugin : public ptl::AbstractPlugin<Plugin, Script>
{
public:
	const char* Name() { return "hyaxe"; }
	bool OnLoad();
};