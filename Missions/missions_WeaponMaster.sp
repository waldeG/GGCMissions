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

char pistolUKey[64] = "pistol_master_5_100";
char pistolUKey2[64] = "pistol_master_15_250";
char pistolUKey3[64] = "pistol_master_50_700";

char submachineUKey[64] = "submachine_master_10_100";
char submachineUKey2[64] = "submachine_master_25_300";
char submachineUKey3[64] = "submachine_master_50_600";

char rifleUKey[64] = "rifle_master_20_100";
char rifleUKey2[64] = "rifle_master_50_250";
char rifleUKey3[64] = "rifle_master_100_500";

char shotgunUKey[64] = "shotgun_master_10_100";
char shotgunUKey2[64] = "shotgun_master_30_350";
char shotgunUKey3[64] = "shotgun_master_60_750";

char sniperUKey[64] = "sniper_master_5_100";
char sniperUKey2[64] = "sniper_master_15_350";
char sniperUKey3[64] = "sniper_master_30_700";


public void OnPluginStart()
{
	Missions_RegisterMission(pistolUKey, "Pistol Master 1", "Kill 5 enemies with a pistol", 5, 100, "", groupTag, true);
	Missions_RegisterMission(pistolUKey2, "Pistol Master 2", "Kill 15 enemies with a pistol", 15, 250, pistolUKey, groupTag, true);
	Missions_RegisterMission(pistolUKey3, "Pistol Master 3", "Kill 50 enemies with a pistol", 50, 700, pistolUKey2, groupTag, true);
	
	Missions_RegisterMission(submachineUKey, "SMG Master 1", "Kill 10 enemies with a Submachine Gun", 10, 100, "", groupTag, true);
	Missions_RegisterMission(submachineUKey2, "SMG Master 2", "Kill 25 enemies with a Submachine Gun", 25, 100, submachineUKey, groupTag, true);
	Missions_RegisterMission(submachineUKey3, "SMG Master 3", "Kill 50 enemies with a Submachine Gun", 50, 100, submachineUKey2, groupTag, true);
	
	Missions_RegisterMission(rifleUKey, "Rifle Master 1", "Kill 20 enemies with an Assault Rifle", 20, 100, "", groupTag, true);
	Missions_RegisterMission(rifleUKey2, "Rifle Master 2", "Kill 50 enemies with an Assault Rifle", 50, 250, rifleUKey, groupTag, true);
	Missions_RegisterMission(rifleUKey3, "Rifle Master 3", "Kill 100 enemies with an Assault Rifle", 100, 500, rifleUKey2, groupTag, true);
	
	Missions_RegisterMission(shotgunUKey, "Shotgun Master 1", "Kill 10 enemies with a shotgun", 10, 100, "", groupTag, true);
	Missions_RegisterMission(shotgunUKey2, "Shotgun Master 2", "Kill 30 enemies with a shotgun", 30, 350, shotgunUKey, groupTag, true);
	Missions_RegisterMission(shotgunUKey3, "Shotgun Master 3", "Kill 60 enemies with a shotgun", 60, 750, shotgunUKey2, groupTag, true);
	
	Missions_RegisterMission(sniperUKey, "Sniper Master 1", "Kill 5 enemies with a sniper rifle", 5, 100, "", groupTag, true);
	Missions_RegisterMission(sniperUKey2, "Sniper Master 2", "Kill 15 enemies with a sniper rifle", 15, 350, sniperUKey, groupTag, true);
	Missions_RegisterMission(sniperUKey3, "Sniper Master 3", "Kill 30 enemies with a sniper rifle", 30, 700, sniperUKey2, groupTag, true);
	
	HookEvent("player_death", onPlayerDeath);
}

public Action onPlayerDeath(Event event, const char[] name, bool dontBroadcast){
	int attacker = GetClientOfUserId(event.GetInt("attacker"));
	if(!isValidClient(attacker))
		return;
	char weaponName[64];
	GetClientWeapon(attacker, weaponName, sizeof(weaponName));
	if(isPistolKill(weaponName)){
		Mission_IncrementMissionProgress(attacker, pistolUKey);
		Mission_IncrementMissionProgress(attacker, pistolUKey2);
		Mission_IncrementMissionProgress(attacker, pistolUKey3);
	}else if(isSMGKill(weaponName)){
		Mission_IncrementMissionProgress(attacker, submachineUKey);
		Mission_IncrementMissionProgress(attacker, submachineUKey2);
		Mission_IncrementMissionProgress(attacker, submachineUKey3);
	}else if(isRifleKill(weaponName)){
		Mission_IncrementMissionProgress(attacker, rifleUKey);
		Mission_IncrementMissionProgress(attacker, rifleUKey2);
		Mission_IncrementMissionProgress(attacker, rifleUKey3);
	}else if(isShotgunKill(weaponName)){
		Mission_IncrementMissionProgress(attacker, shotgunUKey);
		Mission_IncrementMissionProgress(attacker, shotgunUKey2);
		Mission_IncrementMissionProgress(attacker, shotgunUKey3);
	}else if(isSniperKill(weaponName)){
		Mission_IncrementMissionProgress(attacker, sniperUKey);
		Mission_IncrementMissionProgress(attacker,sniperUKey2);
		Mission_IncrementMissionProgress(attacker, sniperUKey3);
	}
}	

public bool isPistolKill(char[] weaponName){
	if (StrContains(weaponName, "hkp2000", false) != -1 || StrContains(weaponName, "p250", false) != -1 || StrContains(weaponName, "glock", false) != -1 || StrContains(weaponName, "deagle", false) != -1 || StrContains(weaponName, "revolver", false) != -1 || StrContains(weaponName, "usp", false) != -1 || StrContains(weaponName, "tec9", false) != -1 || StrContains(weaponName, "fiveseven", false) != -1 || StrContains(weaponName, "cz75a", false) != -1 || StrContains(weaponName, "elite", false) != -1){
		return true;
	}else{
		return false;
	}	
}	

public bool isSMGKill(char[] weaponName){
	if (StrContains(weaponName, "p90", false) != -1 || StrContains(weaponName, "mp7", false) != -1 || StrContains(weaponName, "ump45", false) != -1 || StrContains(weaponName, "mp9", false) != -1 || StrContains(weaponName, "mac10", false) != -1 || StrContains(weaponName, "bizon", false) != -1 ){
		return true;
	}else{
		return false;
	}		
}

public bool isRifleKill(char[] weaponName){
	if (StrContains(weaponName, "ak47", false) != -1 || StrContains(weaponName, "aug", false) != -1 || StrContains(weaponName, "famas", false) != -1 || StrContains(weaponName, "galilar", false) != -1 || StrContains(weaponName, "sg556", false) != -1 || StrContains(weaponName, "m4a1", false) != -1 ){
		return true;
	}else{
		return false;
	}		
}

public bool isShotgunKill(char[] weaponName){
	if(StrContains(weaponName, "xm1014", false) != -1 || StrContains(weaponName, "mag7", false) != -1 || StrContains(weaponName, "nova", false) != -1|| StrContains(weaponName, "sawedoff", false) != -1){
		return true;
	}else{
		return false;
	}
}

public bool isSniperKill(char[] weaponName){
	if (StrContains(weaponName, "awp", false) != -1 || StrContains(weaponName, "g3sg1", false) != -1 || StrContains(weaponName, "ssg08", false) != -1 || StrContains(weaponName, "scar20", false) != -1){
		return true;
	}else{
		return false;
	}		
}



stock bool isValidClient(int client){
    if (!(1 <= client <= MaxClients) || !IsClientInGame(client))
        return false;
    
    return true;
}
