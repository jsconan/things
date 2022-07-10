/**
 * @license
 * GPLv3 License
 *
 * Copyright (c) 2019-2022 Jean-Sebastien CONAN
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
 */

// Import the project's setup.
include <../../config/setup.scad>

// Defines the constraints of the object.
step = 10;
hole = 1.5;
angle = 60;
radius = 150;

// Defines the dimensions of the object.
thickness = layers(3);
shift = arcp(r=vector2D(step), a=angle / 2);

/**
 * Draws a line of holes
 * @param Number length - The length of the line
 * @param Number interval - The distance between holes
 * @param Number diameter - The diameter of each hole
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
applyMode(mode=renderMode) {
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
