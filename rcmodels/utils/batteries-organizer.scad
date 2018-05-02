/**
 * @license
 * GPLv3 License
 *
 * Copyright (c) 2017 Jean-Sebastien CONAN
 *
 * This file is part of jsconan/things.
 *
 * jsconan/things is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * jsconan/things is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with jsconan/things. If not, see <http://www.gnu.org/licenses/>.
 */

/**
 * A simple batteries organizer
 *
 * @author jsconan
 * @version 0.1.0
 */

// As we need to use some shapes, use the right entry point of the library
use <../../lib/camelSCAD/shapes.scad>
include <../../lib/camelSCAD/core/constants.scad>

// We will render the object using the specifications of this mode
renderMode = MODE_PROD;

// Defines the constraints of the print
printResolution = 0.2;
printWidth = 0.4;

// Defines the constraints of the object
batteryCountX = 8;
batteryCountY = 1;
batteryDepth = 20;
batteryType = "BF-1S-550";
batteries = [
    ["BF-1S-260", 12.0, 6.3],   // BetaFPV 1S HV 260mAh
    ["BF-1S-550", 18.0, 7.4],   // BetaFPV 1S HV 550mAh
    ["XT-1S-220", 10.5, 6.2],   // xTron 1S 220mAh
    ["YM-1S-220", 11.5, 6.2],   // YukiModel 1S 220mAh
    ["YM-2S-600", 31, 13.5],    // YukiModel 2S 600mAh
    ["YM-2S-900", 29, 12.5],    // YukiModel 2S 900mAh
    ["YM-2S-1000", 34.5, 12.5]  // YukiModel 2S 1000mAh
];

// Defines the dimensions of the object
thickness = 2 * printWidth;
innerRound = .5;
outerRound = 1;
battery = fetch(batteries, batteryType);
batteryWidth = battery[1];
batteryThickness = battery[2];
overallLength = thickness + (batteryThickness + thickness) * batteryCountX;
overallWidth = thickness + (batteryWidth + thickness) * batteryCountY;
overallHeight = thickness + batteryDepth;

// Sets the minimum facet angle and size using the defined render mode.
// Displays a build box visualization to preview the printer area.
buildBox(mode=renderMode) {
    //sample(size=[overallLength, overallWidth, 5], offset=[0,0,batteryDepth-5])
    difference() {
        cushion([overallLength, overallWidth, overallHeight], d=outerRound);
        translate(-[(overallLength - batteryThickness) / 2 - thickness,
                     (overallWidth - batteryWidth) / 2 - thickness,
                     -thickness]) {
            repeat2D(countX=batteryCountX,
                     countY=batteryCountY,
                     intervalX=[batteryThickness + thickness, 0, 0],
                     intervalY=[0, batteryWidth + thickness, 0]) {
                cushion([batteryThickness, batteryWidth, batteryDepth + ALIGN], d=innerRound);
            }
        }
    }
}
