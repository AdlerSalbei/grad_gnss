#include "script_component.hpp"

/*
 * Author: Salbei
 * Create the satellites for 
 *
 * Arguments:
 * 0: GNSS system <STRING>
 * 1: position <ARRAY>
 * 2: add or remove <BOOL>
 * 3: size <NUMBER or ARRAY>
 * 4: strength <NUMBER>
 *
 * Return Value:
 * None
 *
 * Example:
 * ["GLONASS", [0,0,0], true, 10, 1] call grad_gnss_fnc_jammingSystem
 *
 * Public: No
 */

 params ["_system"];

private _amount = getNumber (configFile >> "grad_gnss" >> _system);
private _satellites = [];

for "_i" from 1 to _amount do {
	private _pos = [worldSize/_i, worldSize/_i, 25000]; 
 
	private _obj = "Land_HelipadEmpty_F" createVehicle _pos; 
	_obj setPosASL _pos;

	_satellites pushBack _obj;
};

missionNamespace setVariable [[QGVAR(satellites) + "_" + format ["%1", _system], _satellites];