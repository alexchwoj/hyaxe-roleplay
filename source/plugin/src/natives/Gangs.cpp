#include "../main.hpp"

cell Script::n_gang_link_dbid(int dbid, int arrayid)
{
	_gang_ids[dbid] = arrayid;
	return 1;
}

cell Script::n_gang_id_from_dbid(int dbid)
{
	auto it = _gang_ids.find(dbid);
	return (it == _gang_ids.end() ? -1 : it->second);
}

cell Script::n_gang_remove_id(int dbid)
{
	_gang_ids.erase(dbid);
	return 1;
}