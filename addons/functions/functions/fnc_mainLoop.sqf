#include "script_component.hpp"

/*
 * Author: Salbei
 * Main Loop for Updates
 *
 * Arguments:
 * 0: gnssSystem <STRING>
 * 1: position <ARRAY>
 * 2: add or remove <BOOL>
 * 3: size <NUMBER or ARRAY>
 * 4: strength <NUMBER>
 *
 * Return Value:
 * None
 *
 * Example:
 * ["GLONASS", [0,0,0], true, 10, 1] call grad_gnss_fnc_mainLoop
 *
 * Public: No
 */

params ["_updateInterval"];

[
	{
		params ["_args", "_handle"];

		private _item = player getVariable [QGVAR(item), objNull];
		private _gps = ((getUnitLoadout player) select 9) select 1;

		if (item isEqualTo _gps) exitWith {
			[_handle] call CBA_fnc_removePerFrameHandler;
		};

		private _system = [configFile >> "CfgWeapons" >> _gps >> "system", "TEXT", ""] call CBA_fnc_getConfigEntry
		private _satellites = missionNamespace getVariable [[QGVAR(satellites) + "_" + format ["%1", _system], []];

		{
			private _intersections = lineIntersectsSurfaces [eyePos player, getPosASL _x, player, _x, true, 10];

			private _amount = count _intersections;
			
		}forEach _satellites;


		private _precision = _underwater + _blockedLines + _jamming;
	},
	_updateInterval,
	[]
] call CBA_fnc_addPerFrameHandler;
