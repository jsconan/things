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
 * A parametric card holder, that can also be utilized as a target for darts gun.
 *
 * @author jsconan
 */

// Import the project's setup.
include <../../config/setup.scad>

// Defines the dimensions of the object
length = 60;
width = 20;
thickness = 1;
slotWidth = 1.2;

// Computes additional dimensions, especially the size of the mount body
cornerRadius = width / 4;
mountLength = length * 0.9;
mountWidth = width / 3;
mountHeight = mountWidth;

// Computes the size of the wedge that will drill the card slot in the card mount
wedgeAngle = atan2(slotWidth / 2, mountHeight) * 2;

// Sets the minimum facet angle and size using the defined render mode.
applyMode(renderMode) {
    // First draw the socle
    cushion(size=[length, width, thickness], r=cornerRadius);

    // Then draw the card mount
    difference() {
        // This is the mount body
        pill(size=[mountLength, mountWidth, mountHeight * 2]);

        // Will remove the unused part of the mount body (the side that is under the socle)
        translateZ(-mountHeight) {
            box(size=[mountLength, mountWidth, mountHeight + thickness / 2]);
        }

        // Will drill the card slot
        translateZ(thickness) {
            rotateY(270) {
                wedge(r=wedgeAngle, h=length, a1=-wedgeAngle / 2, a=wedgeAngle, center=true);
            }
        }
    }
}
