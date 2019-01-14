/**
 * @license
 * GPLv3 License
 *
 * Copyright (c) 2019 Jean-Sebastien CONAN
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
 * A guide to align on a particular angle
 *
 * @author jsconan
 * @version 0.1.0
 */

// As we need to use some shapes, use the right entry point of the library.
use <../lib/camelSCAD/shapes.scad>

// To be able to use the library shared constants we import the definition file.
include <../lib/camelSCAD/core/constants.scad>

// We will render the object using the specifications of this mode
renderMode = MODE_PROD;

// Defines the constraints of the print.
printResolution = 0.2;

// Defines the constraints of the object.
step = 10;
hole = 1.5;
angle = 60;
radius = 150;

// Defines the dimensions of the object.
thickness = printResolution * 3;
shift = arcp(r=vector2D(step), a=angle / 2);

/**
 * Draws a line of holes
 * @param Number length - The length of the line
 * @param Number interval - The distance between holes
 * @param Number diameter - The diameter of eacg hole
 */
module holeLine(length, interval, diameter) {
    count = floor(length / interval) + 1;
    repeat(count=count, intervalX=interval) {
        negativeExtrude(height=thickness) {
            circle(d=diameter);
        }
    }
}

// Sets the minimum facet angle and size using the defined render mode.
// Displays a build box visualization to preview the printer area.
buildBox(mode=renderMode) {
    translate(-[radius / 2, radius / 2 * sin(angle), 0]) {
        difference() {
            wedge(r=radius, h=thickness, a=angle);
            translate(shift / 2) {
                holeLine(length=radius, interval=step, diameter=hole);
                rotateZ(angle) {
                    holeLine(length=radius, interval=step, diameter=hole);
                }
            }
            translate(shift) {
                negativeExtrude(height=thickness) {
                    for(r=[step:step * 2:radius - step]) {
                        difference() {
                            pie(r=r, a=angle);
                            pie(r=r - step, a=angle);
                        }
                    }

                }
            }
        }
    }
}
