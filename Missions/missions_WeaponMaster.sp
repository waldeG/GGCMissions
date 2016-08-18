#pragma semicolon 1

#define DEBUG

#define PLUGIN_AUTHOR "walde"
#define PLUGIN_VERSION "1.00"

#include <sourcemod>
#include <sdktools>
#include <missions>
#include <multicolors>

#pragma newdecls required

public Plugin myinfo = 
{
	name = "Mission: Weapon Master",
	author = PLUGIN_AUTHOR,
	description = "Weapon Master Mission for GGC",
	version = PLUGIN_VERSION,
	url = ""
};

char serverTag[16] = "GGC";
char groupTag[64] = "Weapon Master";

char uKey[64] = "pistol_master_5_100_xC89klOc";
char missionName[256] = "Pistol Master 1";
char missionDescription[1024] = "Kill 5 enemies with a pistol";
char preKey[64] = "";


public void OnPluginStart()
{
	Missions_RegisterMission(uKey, missionName, missionDescription, 5, 100, preKey, groupTag, true);
	HookEvent("player_death", onPlayerDeath);
}

public Action onPlayerDeath(Event event, const char[] name, bool dontBroadcast){
	int attacker = GetClientOfUserId(event.GetInt("attacker"));
	bool killedWithPistol;
	if(!isValidClient(attacker))
		return;
	char weaponName[64];
	GetClientWeapon(attacker, weaponName, sizeof(weaponName));
	if (StrContains(weaponName, "hkp2000", false) != -1 || StrContains(weaponName, "p250", false) != -1 || StrContains(weaponName, "glock", false) != -1 || StrContains(weaponName, "deagle", false) != -1 || StrContains(weaponName, "revolver", false) != -1 || StrContains(weaponName, "usp", false) != -1 || StrContains(weaponName, "tec9", false) != -1 || StrContains(weaponName, "fiveseven", false) != -1 || StrContains(weaponName, "cz75a", false) != -1 || StrContains(weaponName, "elite", false) != -1){
		killedWithPistol = true;
	}	
	if(!killedWithPistol)
		return;
	Mission_IncrementMissionProgress(attacker, uKey);
}		

stock bool isValidClient(int client){
    if (!(1 <= client <= MaxClients) || !IsClientInGame(client))
        return false;
    
    return true;
}
