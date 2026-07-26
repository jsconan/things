/**
 * @license
 * GPLv3 License
 *
 * Copyright (c) 2026 Jean-Sebastien CONAN
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
 * A T-needle.
 *
 * @author jsconan
 */

// Import the project's setup.
include <../../config/setup.scad>

// Defines the constraints of the object.
needleLength = 200;                     // The length of the needle.
needleWidth = 5;                        // The width of the needle.
needleThickness = 5;                    // The thickness of the needle.
needleHeadWidth = needleWidth * 3;      // The width of the needle head.

// Sets the minimum facet angle and size using the defined render mode.
// Displays a build box visualization to preview the printer area.
applyMode(mode=renderMode) {
    // Uncomment the next line to cut a sample from the object
    //sample(size=[DEFAULT_BUILD_PLATE_SIZE, DEFAULT_BUILD_PLATE_SIZE, 5], offset=[0, 0, 0])
    rotateZ(90) {
        rotateX(90) {
            pill(
                size=[needleWidth, needleThickness, needleLength],
                d=[needleWidth, needleThickness],
            );
            translateZ(-(needleLength - needleThickness) / 2) {
                rotateY(90) {
                    pill(
                        size=[needleWidth, needleThickness, needleHeadWidth],
                        d=[needleWidth, needleThickness],
                    );
                }
            }
        }
    }
}
