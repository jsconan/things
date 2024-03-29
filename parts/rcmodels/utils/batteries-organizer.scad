/**
 * @license
 * GPLv3 License
 *
 * Copyright (c) 2017-2022 Jean-Sebastien CONAN
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
 */

// Import the project's setup.
include <../../../config/setup.scad>

// Defines the constraints of the object
batteryCountX = 5;
batteryCountY = 1;
batteryDepth = 20;
batteryType = "TA-1S-300";
batteries = [
    ["BF-1S-260", 12.0, 6.3],   // BetaFPV 1S HV 260mAh
    ["BF-1S-300", 11.6, 6.4],   // BetaFPV 1S HV 300mAh
    ["BF-1S-550", 18.0, 7.4],   // BetaFPV 1S HV 550mAh
    ["BF-3S-300", 16.5, 12.2],  // BetaFPV 3S 300mAh
    ["TA-1S-300", 10.4, 6.7],   // Tattu 1S HV 300mAh
    ["HM-1S-450", 18.5, 6.8],   // Happymodel 1S HV 450mAh
    ["DY-2S-600", 24.5, 12.5],  // DYS 2S 600mAh
    ["XT-1S-220", 10.5, 6.2],   // xTron 1S 220mAh
    ["YM-1S-220", 11.5, 6.2],   // YukiModel 1S 220mAh
    ["YM-2S-600", 31, 13.5],    // YukiModel 2S 600mAh
    ["YM-2S-900", 29, 12.5],    // YukiModel 2S 900mAh
    ["YM-2S-1000", 34.5, 12.5], // YukiModel 2S 1000mAh
];

// Defines the dimensions of the object
thickness = shells(2);
battery = fetch(batteries, batteryType);
batteryWidth = battery[1];
batteryThickness = battery[2];
overallLength = thickness + (batteryThickness + thickness) * batteryCountX;
overallWidth = thickness + (batteryWidth + thickness) * batteryCountY;
overallHeight = thickness + batteryDepth;

// Sets the minimum facet angle and size using the defined render mode.
applyMode(mode=renderMode) {
    // sample(size=[overallLength, overallWidth, 5], offset=[0, 0, batteryDepth - 5])
    difference() {
        box([overallLength, overallWidth, overallHeight]);
        translateZ(thickness) {
            repeatShape2D(size=[batteryThickness + thickness, batteryWidth + thickness], count=[batteryCountX, batteryCountY], center=true) {
                box([batteryThickness, batteryWidth, overallHeight]);
            }
        }
    }
}
