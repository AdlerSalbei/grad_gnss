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
 * 5: direction <NUMBER>
 * 6: is a Rectangle <BOOL>
 * 7: height <NUMBER>
 *
 * Return Value:
 * None
 *
 * Example:
 * ["GLONASS", [0,0,0], true, 10, 1] call grad_gnss_fnc_jammingSystem
 *
 * Public: No
 */

params [
    "_gnssSystem", 
    "_position", 
    "_bool",  
    ["_size", 1], 
    ["_strength", 0], 
    ["_dir", 0], 
    ["_isRectangle", false],
    ["_height", 5]
];

private _jamZonesGVAR = QGVAR(jamSites) + "_" + format ["%1", _gnssSystem];
private _jamZones = missionNamespace getVariable [_jamZonesGVAR, []];

if (_bool) then {

    if (_size isEqualType 0) then {
        _size = [_size, _size];
    };

    _jamZones pushBackUnique [_position, _size, _strength, _dir, _isRectangle, _height];

} else {

    {
        _x params ["_oldPosition"];

        if (_oldPosition isEqualTo _position) exitWith {
            _jamZones deleteAt _forEachIndex;
        };
    }forEach _jamZones;

    missionNamespace setVariable [_jamZonesGVAR, _jamZones];
    
};