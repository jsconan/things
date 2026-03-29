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
 * A replacement axis head.
 *
 * @author jsconan
 */

// Import the project's setup.
include <../../config/setup.scad>

// Defines the constraints of the object.
height= 22;
topDiameter = 6.5;
baseDiameter = 15;
baseHeight = 7;
wingThickness = 2.1;
wingHeight = height;
wingWidth = 9;
wingOverlap = 1;
wingDropout = 3;
baseWingGroove = 3;
baseGroove = 5;
screwHoleDiameter = 2.6;


// Sets the minimum facet angle and size using the defined render mode.
// Displays a build box visualization to preview the printer area.
applyMode(mode=renderMode) {
    // Uncomment the next line to cut a sample from the object
    //sample(size=[DEFAULT_BUILD_PLATE_SIZE, DEFAULT_BUILD_PLATE_SIZE, 5], offset=[0, 0, 0])

    // Axe
    difference() {
        union() {
            cylinder(h=height, d=topDiameter, center=false);
            cylinder(h=baseHeight, d=baseDiameter, center=false);
            repeatRotate(count=2, angle=90, center=true) {
                box(size=[wingWidth, wingThickness, wingHeight], center=false);
            }
            translateX(wingOverlap) {
                box(size=[wingWidth, wingThickness, wingHeight - wingDropout], center=false);
            }
        }
        translateZ(-1) {
            cylinder(h=height + 2, d=screwHoleDiameter, center=false);
            cylinder(h=baseGroove + 1, d=topDiameter, center=false);
        }
        repeatRotate(count=2, angle=90, center=true) {
            translateZ(-1) {
                box(size=[baseDiameter + 1, wingThickness, baseWingGroove + 1], center=false);
            }
        }
    }
}
