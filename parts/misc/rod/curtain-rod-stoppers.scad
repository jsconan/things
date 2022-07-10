/**
 * @license
 * GPLv3 License
 *
 * Copyright (c) 2020-2022 Jean-Sebastien CONAN
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
 * A curtain rod system.
 *
 * A set of rod stoppers
 *
 * @author jsconan
 */

// Import the project's setup.
include <../../../config/misc/rod/setup.scad>

// Sets the minimum facet angle and size using the defined render mode.
// Displays a build box visualization to preview the printer area.
applyMode(mode=renderMode) {
    // Uncomment the next line to cut a sample from the object
    //sample(size=[DEFAULT_BUILD_PLATE_SIZE, DEFAULT_BUILD_PLATE_SIZE, 5], offset=[0, 0, 0])
    distribute(interval=[rodStopperWidth + 5, 0, 0], center=true) {
        rodStopperMale(
            width = rodStopperWidth,
            height = rodStopperHeight,
            diameter = rodStopperDiameter,
            thickness = rodThickness,
            rodWidth = rodWidth,
            rodDiameter = rodDiameter
        );
        rodStopperFemale(
            width = rodStopperWidth,
            height = rodStopperHeight,
            diameter = rodStopperDiameter,
            thickness = rodThickness,
            rodWidth = rodWidth,
            rodDiameter = rodDiameter
        );
    }
}
