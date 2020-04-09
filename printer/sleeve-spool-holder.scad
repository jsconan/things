/**
 * @license
 * GPLv3 License
 *
 * Copyright (c) 2020 Jean-Sebastien CONAN
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
 * A sleeve to adapt on a printed axle for a spool holder.
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
printResolution = 0.2;  // The target layer height
nozzleWidth = 0.4;      // The size of the printer's nozzle
printTolerance = 0.1;   // The print tolerance when pieces need to be assembled

// Defines the constraints of the object.
spoolDiameter = 50;
axleDiameter = 26;
flange = 10;
plate = 3;
tread = 35;
chamfer = 1;

// Defines the dimensions of the object.
height = tread + plate;
flangeDiameter = spoolDiameter + flange * 2;
topBrim = (spoolDiameter - axleDiameter) / 2 - chamfer;
bottomBrim = (flangeDiameter - axleDiameter) / 2 - chamfer;
innerFlange = flange - chamfer;
innerTread = tread - chamfer;
innerPlate = plate - chamfer * 2;
holeHeight = height - chamfer * 2;

startX = axleDiameter / 2 + chamfer;
startY = 0;

// Sets the minimum facet angle and size using the defined render mode.
applyMode(mode=renderMode) {
    rotate_extrude() {
        polygon(
            points=path([
                ["P", startX, startY],
                ["L", -chamfer, chamfer],
                ["V", holeHeight],
                ["L", chamfer, chamfer],
                ["H", topBrim],
                ["L", chamfer, -chamfer],
                ["V", -innerTread],
                ["H", innerFlange],
                ["L", chamfer, -chamfer],
                ["V", -innerPlate],
                ["L", -chamfer, -chamfer],
                ["H", -bottomBrim]
            ]),
            convexity=10
        );
    }
}
