#if defined _interop_header_
    #endinput
#endif
#define _interop_header_

native GetTextDrawCharacterWidth(character, font, bool:proportional = true);
native GetTextDrawStringWidth(const string[], font, outline = 0, bool:proportional = true);
native GetTextDrawLineWidth(const string[], font, outline = 0, bool:proportional = true, start = 0, end = -1);
native GetTextDrawLineCount(const string[]);
native GetTextDrawLineCount_s(ConstAmxString:string) = GetTextDrawLineCount;
native bool:SplitTextDrawString(string[], Float:max_width, Float:letter_size, font, outline = 0, bool:proportional = true, size = sizeof(string));
//native memset(arr[], val, size = sizeof(arr));
native levenshtein(const string1[], const string2[]);

// Argon2 natives
native argon_hash(const password[], memory, parallelism, passes, const callback[], const fmt[] = "", GLOBAL_TAG_TYPES:...);
native argon_check(const password[], const hash[], const callback[], const fmt[] = "", GLOBAL_TAG_TYPES:...);
native argon_set_thread_count(max_threads);
native argon_get_hash(dest[], len = sizeof dest);
native bool:argon_is_equal();

argon_hash_inline(const password[], memory, parallelism, passes, Func:callback<>)
{
    printf("[func] argon_hash_inline(const password[] = \"%s\", memory = %i, parallelism = %i, passes = %i, Func:callback<> = %i)", password, memory, parallelism, passes, _:callback);

    new const ret = argon_hash(password, memory, parallelism, passes, "Indirect_FromCallback", "ii", _:callback, true);
    if(ret)
        Indirect_Claim(callback);

    printf("returned %i", ret);

    return ret;
}

argon_check_inline(const password[], const hash[], Func:callback<>)
{
    printf("[func] argon_check_inline(const password[] = \"%s\", const hash[] = \"%s\", Func:callback<> = %i)", password, hash, _:callback);

    new const ret = argon_check(password, hash, "Indirect_FromCallback", "ii", _:callback, true);
    if(ret)
        Indirect_Claim(callback);

    printf("returned %i", ret);

    return ret;
}