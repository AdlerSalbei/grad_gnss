#include "script_component.hpp"

/*
 * Author: Salbei
 * Jamming a GNSS System
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
 * ["GLONASS", [0,0,0], true, 10, 1] call grad_gnss_fnc_jammingSystem
 *
 * Public: No
 */

params ["_gnssSystem", "_position", "_bool",  ["_size", 0], ["_strength", 0]];

private _jamZonesGVAR = QGVAR(jamSits) + "_" + format ["%1", _gnssSystem];
private _jamZones = missionNamespace getVariable [_jamZonesGVAR, []];

if (_bool) then {

    _jamZones pushBackUnique [_position, _size, _strength];

} else {

    {
        _x params ["_oldPosition"];

        if (_oldPosition isEqualTo _position) exitWith {
            _jamZones deleteAt _forEachIndex;
        };
    }forEach _jamZones;

    missionNamespace setVariable [_jamZonesGVAR, _jamZones];
    
};