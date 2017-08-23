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
 * A parametric mesh grid
 *
 * @author jsconan
 */

// As we need to use some shapes, use the right entry point of the library
use <../lib/camelSCAD/shapes.scad>
include <../lib/camelSCAD/core/constants.scad>

// We will render the object using the specifications of this mode
renderMode = MODE_PROD;

// Defines the dimensions of the object
length = 120;
width = 120;
thickness = 2;
corner = 8;
paddingX = 6;
paddingY = 6;
holeDiameter = 5;
holeIntervalX = length - 2 * holeDiameter;
holeIntervalY = width - 2 * holeDiameter;

cellCountX = 10;
cellCountY = 10;
cellSpaceX = 1;
cellSpaceY = 1;
meshLength = length - 2 * paddingX;
meshWidth  = width - 2 * paddingY;

// Sets the minimum facet angle and size using the defined render mode.
// Displays a build box visualization to preview the printer area.
applyMode(mode=renderMode) {
    difference() {
        cushion([length, width, thickness], d=corner);

        negativeExtrude(thickness, direction=2) {
            translate([holeIntervalX, holeIntervalY, 0] / -2) {
                repeat2D(countX=2, countY=2, intervalX=[holeIntervalX, 0, 0], intervalY=[0, holeIntervalY, 0]) {
                    circle(d=holeDiameter);
                }
            }

            mesh(
                size  = [meshLength, meshWidth],
                count = [cellCountX, cellCountY],
                gap   = [cellSpaceX, cellSpaceY],
                linear = true,
                even = true,
                pointy = false
            );
        }
    }
}
