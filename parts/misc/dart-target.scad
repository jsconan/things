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
 * A parametric target for darts gun.
 *
 * @author jsconan
 */

// Import the project's setup.
include <../../config/setup.scad>

// Defines the dimensions of the object
targetDiameter = 50;
socleLength = 60;
socleWidth = 20;
socleAngle = 80;
thickness = 1;
rings = 3;

// Computes additional dimensions, especially the size of the mount body
ringDiameter = targetDiameter / rings;
ringWidth = ringDiameter / 4;
armWidth = ringWidth / 2;
armLength = targetDiameter * 1.1;
cornerRadius = socleWidth / 4;

// Sets the minimum facet angle and size using the defined render mode.
applyMode(mode=renderMode) {
    // First draw the rings
    cylinder(d=ringDiameter, h=thickness);
    if (rings > 1) {
        for(i = [2 : rings]) {
            pipe(d=ringDiameter * i, w=ringWidth, h=thickness);
        }
    }

    // Then draw the cross
    box(l=armLength, w=armWidth, h=thickness);
    box(w=armLength, l=armWidth, h=thickness);

    // Finally draw the socle
    translate([0, armWidth - (socleWidth + targetDiameter) / 2, 0]) {
        trapeziumBox(a=socleLength * 0.8, b=armWidth * 2, w=socleWidth, h=thickness);
    }
    translate([0, armWidth - (socleWidth + targetDiameter / 2), 0]) {
        rotateX(socleAngle) {
            translateY(socleWidth / 2) {
                cushion(size=[socleLength, socleWidth, thickness], r=cornerRadius);
            }
        }
    }
}
