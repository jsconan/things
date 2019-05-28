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
 * A needle for the BetaFPV Beta85X HD,
 * to activate the camera recording or
 * to remove the SD card.
 *
 * @author jsconan
 * @version 0.1.0
 */

// As we need to use some shapes, use the right entry point of the library
include <../../lib/camelSCAD/shapes.scad>

// We will render the object using the specifications of this mode
renderMode = MODE_PROD;

// Defines the constraints of the print
printResolution = 0.2;

// Defines the constraints of the object
needleWidth = 2;
needleLength = 20;
needleThickness = 1.8;
handleWidth = 15;
handleLength = 60;

// Defines the dimensions of the object
needleSide = (handleWidth - needleWidth) / 2;

// Sets the minimum facet angle and size using the defined render mode.
// Displays a build box visualization to preview the printer area.
//sample(size=[DEFAULT_BUILD_PLATE_SIZE, DEFAULT_BUILD_PLATE_SIZE, 2], offset=[0, 0, 2])
buildBox(mode=renderMode) {
    negativeExtrude(needleThickness) {
        polygon(
            points=path([
                ["P", handleWidth / 2, 0],
                ["C", [needleSide, needleLength], 270, 180],
                ["H", -needleWidth],
                ["C", [needleSide, needleLength], 360, 270],
                ["C", [handleWidth / 2, handleLength], 180, 360]
            ]),
            convexity = 10
        );
    }
}
