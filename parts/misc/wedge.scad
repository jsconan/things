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
 * A parametric wedge.
 *
 * @author jsconan
 */

// Import the project's setup.
include <../../config/setup.scad>

// Defines the dimensions of the object
length = 30;
leftWidth = 10.5;
rightWidth = 11.3;
height = 25;

// Sets the minimum facet angle and size using the defined render mode.
applyMode(mode=renderMode) {
    // Uncomment the next line to cut a sample from the object
    // sample([standWidth + 1, 30, 20], offset=[0, standWidth/2 + 30, 0], center=true)
    linear_extrude(height=height, convexity=10) {
        polygon(points=path(
            [
                ["P", length / 2, -rightWidth / 2],
                ["V", rightWidth],
                ["H", -length],
                ["V", -leftWidth],
            ]
        ));
    }
}
