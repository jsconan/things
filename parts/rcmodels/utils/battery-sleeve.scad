/**
 * @license
 * GPLv3 License
 *
 * Copyright (c) 2022 Jean-Sebastien CONAN
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
 * A battery sleeve that ease the use of thin batteries with FPV goggles.
 *
 * @author jsconan
 */

// Import the project's setup.
include <../../../config/setup.scad>

// Defines the constraints of the object
batteryThickness = 16.5;
batteryWidth = 34.5;
sleeveThickness = 23;
sleeveWidth = 45;
sleeveHeight = 50;
sleeveRound = 5;


// Sets the minimum facet angle and size using the defined render mode.
applyMode(mode=renderMode) {
    // sample(size=[DEFAULT_BUILD_PLATE_SIZE, DEFAULT_BUILD_PLATE_SIZE, 5], offset=[0, 0, 0], center=true)
    difference() {
        cushion(size=[sleeveWidth, sleeveThickness, sleeveHeight], r=sleeveRound);
        translateZ(-1) {
            box([batteryWidth, batteryThickness, sleeveHeight + 2]);
        }
    }
}
