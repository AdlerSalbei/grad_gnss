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
 * [] call grad_gnss_fnc_createSatellites
 *
 * Public: No
 */


private _satellites = [];

 {
    private _obj = "Land_HelipadEmpty_F" createVehicle _x; 
    _obj setPosASL _x;

    _satellites pushBack _obj;
 }forEach [[0,0,10000], [worldSize,0,10000], [0,worldSize,10000], [worldSize,worldSize,10000]];

missionNamespace setVariable [QGVAR(satellites), _satellites];