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

/**
 * Defines a battery.
 * @param String name - The name of the defined battery.
 * @param Number width - The width of the battery's body.
 * @param Number height - The thickness of the battery's body.
 * @param Number length - The length of the battery, including the connector.
 */
function define(name, width, height, length) = [name, width, height, length];

// List of known batteries
batteries = [
    define(name="BF-1S-260",  width=12.0, height=6.3,  length=70), // BetaFPV 1S HV 260mAh
    define(name="BF-1S-300",  width=11.6, height=6.4,  length=70), // BetaFPV 1S HV 300mAh
    define(name="BF-1S-550",  width=18.0, height=7.4,  length=70), // BetaFPV 1S HV 550mAh
    define(name="BF-3S-300",  width=16.5, height=12.2, length=70), // BetaFPV 3S 300mAh
    define(name="TA-1S-300",  width=10.4, height=6.7,  length=70), // Tattu 1S HV 300mAh
    define(name="HM-1S-450",  width=18.5, height=6.8,  length=70), // Happymodel 1S HV 450mAh
    define(name="DY-2S-600",  width=24.5, height=12.5, length=70), // DYS 2S 600mAh
    define(name="XT-1S-220",  width=10.5, height=6.2,  length=70), // xTron 1S 220mAh
    define(name="YM-1S-220",  width=11.5, height=6.2,  length=70), // YukiModel 1S 220mAh
    define(name="YM-2S-600",  width=31.0, height=13.5, length=70), // YukiModel 2S 600mAh
    define(name="YM-2S-900",  width=29.0, height=12.5, length=70), // YukiModel 2S 900mAh
    define(name="YM-2S-1000", width=34.5, height=12.5, length=70), // YukiModel 2S 1000mAh
];

// Defines the constraints of the object
batteryCountX = 6;
batteryCountY = 1;
batteryDepth = 20;
batteryType = "TA-1S-300";

// Defines the dimensions of the object
thickness = shells(2);
battery = fetch(batteries, batteryType);
batteryWidth = battery[1];
batteryThickness = battery[2];
batteryLength = battery[3];
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
