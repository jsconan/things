/**
 * @license
 * GPLv3 License
 *
 * Copyright (c) 2021-2022 Jean-Sebastien CONAN
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
 * A helper to place an ikea handle.
 *
 * @author jsconan
 */

// Import the project's setup.
include <../../config/setup.scad>

// Defines the constraints of the object.
pencilLeadSize = 0.7;
markWidth = 20;
markCount = 2;
markInterval = 96;
markX = 15;
markY = 15;
paddingX = 30;
paddingY = 5;
plateThickness = .6;
wallThickness = .5;
wallHeight = 10;

// Defines the dimensions of the object.
innerLength = markInterval * (markCount - 1);
length =innerLength + (markX + paddingX) * 2;
width = (markY + paddingY) * 2;

// Draws a cross-mark at the origin
module mark(width, height, thickness) {
    box([width, thickness, height], center=true);
    box([thickness, width, height], center=true);
}

// Sets the minimum facet angle and size using the defined render mode.
applyMode(mode=renderMode) {
    repeatMirror(axis = [0, 1, 0]) {
        translateY(width/2 + 10) {
            difference() {
                box([length, width, wallHeight]);
                translate([wallThickness, wallThickness, plateThickness]) {
                    box([length, width, wallHeight]);
                }
                translateX(-innerLength / 2) {
                    repeat(
                        count = markCount,
                        intervalX = markInterval
                    ) {
                        mark(markWidth, wallHeight, pencilLeadSize);
                    }
                }
            }
        }
    }
}
