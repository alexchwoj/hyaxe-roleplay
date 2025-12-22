<p align="center">
    <img src="images/hyaxe.png" alt="Hyaxe logo" width="360" />
</p>
<p align="center">Version 2 of the well-known Hyaxe Roleplay San Andreas Multiplayer server, refactored and adapted for release as an open-source project.</p>

## History

Hyaxe was founded in 2019 as a roleplay server and was consistently recognized for its high standards in both code quality and gameplay innovation. In 2020, it became a pioneer among Spanish-speaking servers by introducing voice chat, which—combined with the pandemic—led to massive growth, reaching over 200 concurrent players and more than 500,000 registered accounts.

By mid-2022, a complete rewrite of the server began, prioritizing system robustness, maintainability, and overall code quality.

## Features

- **Vehicles:** full vehicle system (ownership, spawning, fuel, trunks, dealerships, rentals, tuning and repairs).
- **Jobs:** multiple job systems (trucker, gunsmaker, lawnmower, fisherman) with job sites, paychecks and callbacks.
- **Gangs & Territories:** gang creation, ranks/permissions, territory control and gang events.
- **Stores & Shops:** in-game shops, dealerships, clothing stores, hotdog stands and item displays.
- **Weather:** dynamic weather cycles and presets.
- **Anticheat:** multi-rule detection (speedhack, teleport, rapidfire, invalid sync, etc.) with configurable punishments.
- **Economy & ATM:** bank accounts, ATMs and transfer events.
- **Enter/Exits:** interior/teleport points with labels, areas and camera handling.
- **Fuel Stations:** refueling locations and fuel mechanics integrated with vehicles.
- **Actors & NPCs:** robbable actors and NPC interactions.
- **Admin tools:** admin/monitoring utilities.
- **Textdraws / UI:** HUD elements, inventory UI, phone and textdraw management.
- **Safe zones & Hospital:** safe zone enforcement and hospital/death handling.
- **Tuning & Customization:** vehicle tuning, paintjobs and model data.
- **Events & Seasonal:** support for events and seasonal modules (e.g., Halloween, fireworks).

## Run queries

```sql
DELIMITER $$

CREATE OR REPLACE PROCEDURE REGISTER_ACCOUNT(
    IN P_NAME VARCHAR(24), IN P_EMAIL VARCHAR(128), IN P_PASSWORD BINARY(128),
    IN P_SKIN SMALLINT, IN P_SEX TINYINT, IN P_MONEY INT,
    IN P_X FLOAT, IN P_Y FLOAT, IN P_Z FLOAT, IN P_ANGLE FLOAT,
    IN P_PLAYERID SMALLINT, IN P_CFG_BITS TEXT, IN P_IP VARCHAR(16),
    OUT ACC_ID INT UNSIGNED
)
BEGIN
  DECLARE accid INT UNSIGNED;

    INSERT INTO `ACCOUNT`
        (`NAME`, `EMAIL`, `EMAIL_VERIFICATION_CODE`, `PASSWORD`, `SKIN`, `SEX`, `LEVEL`, `XP`, `MONEY`, `POS_X`, `POS_Y`, `POS_Z`, `ANGLE`, `CURRENT_CONNECTION`, `CURRENT_PLAYERID`, `CONFIG_BITS`)
    VALUES
        (P_NAME, P_EMAIL, REPLACE(UUID(), '-', ''), P_PASSWORD, P_SKIN, P_SEX, 1, 0, P_MONEY, P_X, P_Y, P_Z, P_ANGLE, UNIX_TIMESTAMP(), P_PLAYERID, P_CFG_BITS);

    SELECT LAST_INSERT_ID() AS ACCOUNT_ID;
    SET accid = LAST_INSERT_ID();

    INSERT INTO `PLAYER_WEAPONS` (`ACCOUNT_ID`) VALUES (accid);
    INSERT INTO `BANK_ACCOUNT` (`ACCOUNT_ID`) VALUES (accid);
    INSERT INTO `CONNECTION_LOG` (`ACCOUNT_ID`, `IP_ADDRESS`) VALUES (accid, P_IP);
END;
$$

DELIMITER ;
```

## Gallery

<div align="center">
    <div style="display:flex;flex-wrap:wrap;justify-content:center;max-width:1000px;">
        <div style="margin:8px;text-align:center;">
            <a href="https://www.youtube.com/watch?v=tmU0KFKOkf0" target="_blank">
                <img src="https://img.youtube.com/vi/tmU0KFKOkf0/hqdefault.jpg" alt="Hyaxe 1.0 vs Hyaxe 2.0 | Brief comparison" width="320" />
            </a>
            <div style="max-width:320px">Hyaxe 1.0 vs Hyaxe 2.0 | Brief comparison</div>
        </div>
        <div style="margin:8px;text-align:center;">
            <a href="https://www.youtube.com/watch?v=4iwvFKbTejA" target="_blank">
                <img src="https://img.youtube.com/vi/4iwvFKbTejA/hqdefault.jpg" alt="Grill" width="320" />
            </a>
            <div style="max-width:320px">Grill</div>
        </div>
        <div style="margin:8px;text-align:center;">
            <a href="https://www.youtube.com/watch?v=QM4JX0XckmE" target="_blank">
                <img src="https://img.youtube.com/vi/QM4JX0XckmE/hqdefault.jpg" alt="New item: Dynamite" width="320" />
            </a>
            <div style="max-width:320px">New item: Dynamite</div>
        </div>
        <div style="margin:8px;text-align:center;">
            <a href="https://www.youtube.com/watch?v=HZAcgJwBQYw" target="_blank">
                <img src="https://img.youtube.com/vi/HZAcgJwBQYw/hqdefault.jpg" alt="Fishing job" width="320" />
            </a>
            <div style="max-width:320px">Fishing job</div>
        </div>
        <div style="margin:8px;text-align:center;">
            <a href="https://www.youtube.com/watch?v=PaqUDb_RBwA" target="_blank">
                <img src="https://img.youtube.com/vi/PaqUDb_RBwA/hqdefault.jpg" alt="Mechanic Workshop | Demonstration" width="320" />
            </a>
            <div style="max-width:320px">Mechanic Workshop | Demonstration</div>
        </div>
        <div style="margin:8px;text-align:center;">
            <a href="https://www.youtube.com/watch?v=MIbdOgy1UK8" target="_blank">
                <img src="https://img.youtube.com/vi/MIbdOgy1UK8/hqdefault.jpg" alt="Fireworks update" width="320" />
            </a>
            <div style="max-width:320px">Fireworks update</div>
        </div>
    </div>
</div>
