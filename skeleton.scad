/**
 * @license
 * GPLv3 License
 *
 * Copyright (c) 2017-2020 Jean-Sebastien CONAN
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
 * A base skeleton to start designing a thing using the camelSCAD library.
 *
 * @author jsconan
 * @version 0.1.0
 */

// As we need to use some shapes, use the right entry point of the library.
use <lib/camelSCAD/shapes.scad>

// To be able to use the library shared constants we import the definition file.
include <lib/camelSCAD/core/constants.scad>

// We will render the object using the specifications of this mode
renderMode = MODE_PROD;

// Defines the constraints of the print.
printResolution = 0.2;  // the target layer height
nozzle = 0.4;           // the size of the print nozzle
printTolerance = 0.1;   // The print tolerance when pieces need to be assembled

// Defines the constraints of the object.
//count = 2;

// Defines the dimensions of the object.
//length = 10;
//width = 10;
//height = 10;

// Displays a build box visualization to preview the printer area.
buildBox(center=true);

// Sets the minimum facet angle and size using the defined render mode.
applyMode(mode=renderMode) {
    // Uncomment the next line to cut a sample from the object
    //sample(size=[DEFAULT_BUILD_PLATE_SIZE, DEFAULT_BUILD_PLATE_SIZE, 5], offset=[0, 0, 0])
    union() {
        // This is where to define the object
    }
}
