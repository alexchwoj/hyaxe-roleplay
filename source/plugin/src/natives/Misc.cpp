#include "../main.hpp"

cell Script::n_levenshtein(std::string s1, std::string s2)
{
	if (s1.size() > s2.size())
	{
		std::swap(s1, s2);
	}

	const std::size_t min_size = s1.size(), max_size = s2.size();
	std::vector<std::size_t> lev_dist(min_size + 1);

	for (std::size_t i = 0; i <= min_size; ++i)
		lev_dist[i] = i;

	for (std::size_t j = 1; j <= max_size; ++j) 
	{
		std::size_t previous_diagonal = lev_dist[0], previous_diagonal_save;
		++lev_dist[0];

		for (std::size_t i = 1; i <= min_size; ++i) 
		{
			previous_diagonal_save = lev_dist[i];

			if (s1[i - 1] == s2[j - 1]) 
			{
				lev_dist[i] = previous_diagonal;
			}
			else 
			{
				lev_dist[i] = std::min({ lev_dist[i - 1], lev_dist[i], previous_diagonal }) + 1;
			}

			previous_diagonal = previous_diagonal_save;
		}
	}

	return lev_dist[min_size];
}