/*
	Author: TheTimidShade

	Description:
		Checks if unit is a zombie or not (Ravage/Ryans Zombies)

	Parameters:
		1: OBJECT - Unit to check
		
	Returns:
		BOOL - True if unit is a zombie
*/

params ["_unit"];
private _isZombie = false;
{
	if (_unit isKindOf _x) exitWith {_isZombie = true;};
} forEach ["zombie", "RyanZombieCivilian_F", "RyanZombieB_Soldier_base_F"];
_isZombie