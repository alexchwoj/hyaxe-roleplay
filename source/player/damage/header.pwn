#if defined _damage_header_
    #endinput
#endif
#define _damage_header_

new
    g_rgiLastDamageTick[MAX_PLAYERS + 1][55],
    g_rgiLastDeathTick[MAX_PLAYERS + 1],
    g_rgiLastBulletTick[MAX_PLAYERS + 1],
    g_rgiWeaponsDamage[] = {
        1, // 0 - Fist
        1, // 1 - Brass knuckles
        1, // 2 - Golf club
        1, // 3 - Nitestick
        1, // 4 - Knife
        1, // 5 - Bat
        1, // 6 - Shovel
        1, // 7 - Pool cue
        1, // 8 - Katana
        1, // 9 - Chainsaw
        1, // 10 - Dildo
        1, // 11 - Dildo 2
        1, // 12 - Vibrator
        1, // 13 - Vibrator 2
        1, // 14 - Flowers
        1, // 15 - Cane
        83, // 16 - Grenade
        0, // 17 - Teargas
        1, // 18 - Molotov
        9, // 19 - Vehicle M4 (custom)
        46, // 20 - Vehicle minigun (custom)
        82, // 21 - Vehicle rocket (custom)
        4, // 22 - Colt 45
        6, // 23 - Silenced
        22, // 24 - Deagle
        30, // 25 - Shotgun
        12, // 26 - Sawed-off
        10, // 27 - Spas
        6, // 28 - UZI
        8, // 29 - MP5
        10, // 30 - AK47
        13, // 31 - M4
        8, // 32 - Tec9
        24, // 33 - Cuntgun
        41, // 34 - Sniper
        82, // 35 - Rocket launcher
        82, // 36 - Heatseeker
        1, // 37 - Flamethrower
        46, // 38 - Minigun
        82, // 39 - Satchel
        0, // 40 - Detonator
        0, // 41 - Spraycan
        0, // 42 - Fire extinguisher
        0, // 43 - Camera
        0, // 44 - Night vision
        0, // 45 - Infrared
        0, // 46 - Parachute
        0, // 47 - Fake pistol
        2, // 48 - Pistol whip (custom)
        10, // 49 - Vehicle
        330, // 50 - Helicopter blades
        82, // 51 - Explosion
        1, // 52 - Car park (custom)
        1, // 53 - Drowning
        10  // 54 - Splat
    },
    Float:g_rgfWeaponsRange[] = {
        1.6, // 0 - Fist
        1.6, // 1 - Brass knuckles
        1.6, // 2 - Golf club
        1.6, // 3 - Nitestick
        1.6, // 4 - Knife
        1.6, // 5 - Bat
        1.6, // 6 - Shovel
        1.6, // 7 - Pool cue
        1.6, // 8 - Katana
        1.6, // 9 - Chainsaw
        1.6, // 10 - Dildo
        1.6, // 11 - Dildo 2
        1.6, // 12 - Vibrator
        1.6, // 13 - Vibrator 2
        1.6, // 14 - Flowers
        1.6, // 15 - Cane
        40.0, // 16 - Grenade
        40.0, // 17 - Teargas
        40.0, // 18 - Molotov
        90.0, // 19 - Vehicle M4 (custom)
        75.0, // 20 - Vehicle minigun (custom)
        0.0, // 21 - Vehicle rocket (custom)
        35.0, // 22 - Colt 45
        35.0, // 23 - Silenced
        35.0, // 24 - Deagle
        40.0, // 25 - Shotgun
        35.0, // 26 - Sawed-off
        40.0, // 27 - Spas
        35.0, // 28 - UZI
        45.0, // 29 - MP5
        70.0, // 30 - AK47
        90.0, // 31 - M4
        35.0, // 32 - Tec9
        100.0, // 33 - Cuntgun
        320.0, // 34 - Sniper
        55.0, // 35 - Rocket launcher
        55.0, // 36 - Heatseeker
        5.1, // 37 - Flamethrower
        75.0, // 38 - Minigun
        40.0, // 39 - Satchel
        25.0, // 40 - Detonator
        6.1, // 41 - Spraycan
        10.1, // 42 - Fire extinguisher
        100.0, // 43 - Camera
        100.0, // 44 - Night vision
        100.0, // 45 - Infrared
        1.6  // 46 - Parachute
    },
    g_rgiWeaponsShootRate[] = {
        250, // 0 - Fist
        250, // 1 - Brass knuckles
        250, // 2 - Golf club
        250, // 3 - Nitestick
        250, // 4 - Knife
        250, // 5 - Bat
        250, // 6 - Shovel
        250, // 7 - Pool cue
        250, // 8 - Katana
        30, // 9 - Chainsaw
        250, // 10 - Dildo
        250, // 11 - Dildo 2
        250, // 12 - Vibrator
        250, // 13 - Vibrator 2
        250, // 14 - Flowers
        250, // 15 - Cane
        0, // 16 - Grenade
        0, // 17 - Teargas
        0, // 18 - Molotov
        90, // 19 - Vehicle M4 (custom)
        20, // 20 - Vehicle minigun (custom)
        0, // 21 - Vehicle rocket (custom)
        160, // 22 - Colt 45
        120, // 23 - Silenced
        120, // 24 - Deagle
        800, // 25 - Shotgun
        120, // 26 - Sawed-off
        120, // 27 - Spas
        50, // 28 - UZI
        50, // 29 - MP5
        60, // 30 - AK47
        60, // 31 - M4
        70, // 32 - Tec9
        800, // 33 - Cuntgun
        900, // 34 - Sniper
        0, // 35 - Rocket launcher
        0, // 36 - Heatseeker
        300, // 37 - Flamethrower
        20, // 38 - Minigun
        0, // 39 - Satchel
        0, // 40 - Detonator
        10, // 41 - Spraycan
        10, // 42 - Fire extinguisher
        0, // 43 - Camera
        0, // 44 - Night vision
        0, // 45 - Infrared
        0, // 46 - Parachute
        0, // 47 - Fake pistol
        400, // 48 - Pistol whip (custom)
        500, // 49 - Vehicle
        500, // 50 - Helicopter blades
        500, // 51 - Explosion
        500, // 52 - Car park (custom)
        1, // 53 - Drowning
        1  // 54 - Splat
    }
;

forward OnPlayerDamage(playerid, issuerid, amount, weaponid, bodypart);