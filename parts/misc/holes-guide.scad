/**
 * @license
 * GPLv3 License
 *
 * Copyright (c) 2025 Jean-Sebastien CONAN
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
 * A simple spacer with screw holes.
 *
 * @author jsconan
 */

// Import the project's setup.
include <../../config/setup.scad>

// Defines the constraints of the object.
screwHoleCount = 2;
screwHoleDiameter = 5;
screwHoleInterval = 59.5;
depth = 70;

// Sets the minimum facet angle and size using the defined render mode.
// Displays a build box visualization to preview the printer area.
applyMode(mode=renderMode) {
    // Uncomment the next line to cut a sample from the object
    //sample(size=[DEFAULT_BUILD_PLATE_SIZE, DEFAULT_BUILD_PLATE_SIZE, 5], offset=[0, 0, 0])
    rotateX(90){
        repeat(count=screwHoleCount, interval=[screwHoleInterval, 0, 0], center=true) {
            cylinder(h=depth, d=screwHoleDiameter, center=true);
        }
        translateZ(depth / 2 - screwHoleDiameter) {
            box(size=[screwHoleInterval, screwHoleDiameter, screwHoleDiameter], center=false);
        }
    }
}
