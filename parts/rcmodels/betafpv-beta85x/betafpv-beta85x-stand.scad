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
 * A stand for the BetaFPV Beta85X.
 *
 * @author jsconan
 */

// Import the project's setup.
include <../../../config/setup.scad>

// Defines the constraints of the object
motorDistance = 85;
pillarHeight = 30;
pillarDiameter = 10;
platformDiameter = 20;
plateDiameter = 40;
plateThickness = 3;

// Defines the dimensions of the object
armLength = (motorDistance - plateDiameter) / 2 + pillarDiameter;
platformHeight = platformDiameter - pillarDiameter;
pillarBottom = pillarHeight - platformHeight;

// Sets the minimum facet angle and size using the defined render mode.
//sample(size=[DEFAULT_BUILD_PLATE_SIZE, DEFAULT_BUILD_PLATE_SIZE, 2], offset=[0, 0, 2])
applyMode(mode=renderMode) {
    // the base
    negativeExtrude(height=plateThickness) {
        ring(d=plateDiameter, w=pillarDiameter);
        repeatRotate(count=4) {
            translateY((armLength + plateDiameter - pillarDiameter) / 2) {
                stadium(w=pillarDiameter, h=armLength, d=pillarDiameter);
            }
        }
    }

    // the pillars
    repeatRotate(count=4) {
        translate([motorDistance / 2, 0, plateThickness]) {
            cylinder(d=pillarDiameter, h=pillarBottom);
            translateZ(pillarBottom) {
                cylinder(d1=pillarDiameter, d2=platformDiameter, h=platformHeight);
            }
        }
    }
}
