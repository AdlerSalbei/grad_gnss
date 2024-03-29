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

        if (_item isEqualTo _gps) exitWith {
            [_handle] call CBA_fnc_removePerFrameHandler;
        };

        private _system = [configFile >> "CfgWeapons" >> _gps >> "system", "TEXT", ""] call CBA_fnc_getConfigEntry;
        
        private _eyePos = eyePos player;
        private _blockedLines = 0;

        private _underwater = if ((_eyePos select 2) < 0) then {
            (abs(round (_eyePos select 2))) min 10
        } else {
            private _satellites = missionNamespace getVariable [QGVAR(satellites) + "_" + format ["%1", _system], []];
            {
                private _intersections = lineIntersectsSurfaces [_eyePos, getPosASL _x, player, _x, true, 10];

                private _amount = count _intersections;
                
            }forEach _satellites;

            0
        };

		private _jamming = 0;
		
		private _jamZonesGVAR = QGVAR(jamSites) + "_" + format ["%1", _gnssSystem];
		private _zones = missionNamespace getVariable [_jamZonesGVAR, []];
		if (count _zones > 0) then {
			{
				_x params ["_position", "_size", "_strength", "_dir", "_isRectangle", "_height"];
				
				private _inArea = player inArea [_position, (_size select 0), (_size select 1), _dir, _isRectangle, _height];

				if (_inArea) then {
					_jamming = (_jamming + (_strength / (floor (player distance2D _position)))) min 10;
				};
			}forEach _zones;
		};

        private _precision = _underwater + _blockedLines + _jamming;
    },
    _updateInterval,
    []
] call CBA_fnc_addPerFrameHandler;
