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
 * A screw driver designed to fit the Magimix Nespresso screws.
 *
 * @author jsconan
 */

// As we need to use some shapes, use the right entry point of the library
use <../lib/camelSCAD/shapes.scad>
include <../lib/camelSCAD/core/constants.scad>

// We will render the object using the specifications of this mode
renderMode = MODE_PROD;

// Defines the dimensions of the object
outerDiameter = 8.00;
innerDiameter = 3.50;
innerLength   = 4.00;
grooveDepth   = 2.00;
socketLength  = 30;
handleLength  = 20;

// Sets the minimum facet angle and size using the defined render mode.
applyMode(renderMode) {
    difference() {
        bullet(size=[outerDiameter, outerDiameter, socketLength], d=outerDiameter);
        translateZ(socketLength - handleLength) {
            pipe(d=3 * outerDiameter, w=outerDiameter, h=handleLength + ALIGN, $fn=6);
        }
        translateZ(-ALIGN) {
            slot(size=[innerLength, innerDiameter, grooveDepth], d=innerDiameter);
        }
    }
}
