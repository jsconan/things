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
 * A parametric honeycomb box
 *
 * @author jsconan
 * @version 0.1.0
 */

// As we need to use some shapes, use the right entry point of the library
use <../lib/camelSCAD/shapes.scad>
include <../lib/camelSCAD/core/constants.scad>

// We will render the object using the specifications of this mode
renderMode = MODE_PROD;

// Defines the constraints of the print
printResolution = 0.2;
printWidth = 0.4;

// Defines the constraints of the object
cellCountX = 6;
cellCountY = 4;
cellDepth = 20;
cellLength = 13;
cellWidth = 13;

// Defines the dimensions of the object
wall = roundBy(.5, printWidth);
base = roundBy(.7, printResolution);
count = divisor2D([cellCountX, cellCountY]);
innerCell = [cellLength, cellWidth] / cos(30);
outerCell = vadd(innerCell, wall);
outerHeight = base + cellDepth;
pointy = true;
linear = true;
even = true;
offset = offsetHexGrid(size=outerCell, count=count, pointy=pointy, linear=linear, even=even);
size = sizeHexGrid(size=outerCell, count=count, pointy=pointy, linear=linear, even=even);

// Sets the minimum facet angle and size using the defined render mode.
// Displays a build box visualization to preview the printer area.
buildBox(mode=renderMode) {
    //sample(size=apply3D(size, z=5), offset=[0,0,outerHeight-5])
    for(hex = buildHexGrid(count=count, linear=linear)) {
        translate(offset + coordHexCell(hex=hex, size=outerCell, linear=linear, even=even, pointy=pointy)) {
            difference() {
                linear_extrude(outerHeight) {
                    hexagon(size=outerCell, pointy=pointy);
                }
                translateZ(base) {
                    linear_extrude(outerHeight) {
                        hexagon(size=innerCell, pointy=pointy);
                    }
                }
            }
        }
    }
}
