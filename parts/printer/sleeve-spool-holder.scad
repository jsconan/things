/**
 * @license
 * GPLv3 License
 *
 * Copyright (c) 2020-2026 Jean-Sebastien CONAN
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
 */

// Import the project's setup.
include <../../config/setup.scad>

/**
 * Defines a spool hole.
 * @param String name - The name of the defined spool.
 * @param Number holeDiameter - The diameter of the spool hole.
 * @param Number depth - The depth of the sleeve inside the spool.
 */
function define(name, holeDiameter, depth) = [name, holeDiameter, depth];
NAME = 0;   // The index of the name in the spool definition.
HOLE = 1;   // The index of the hole diameter in the spool definition.
DEPTH = 2;  // The index of the depth in the spool definition.

// List of known spool brands and the dimension of their holes.
spools = [
    define(name="generic",  holeDiameter=50, depth=35),   // Generic spools
    define(name="prusa",  holeDiameter=45, depth=20),     // Prusa spools
];

// Defines the constraints of the object.
spoolBrand = "prusa";   // The brand of the spool to fit the sleeve on
axleDiameter = 26;      // The diameter of the fixed axle to fit in the sleeve
flangeWidth = 10;       // The width of the sleeve's flange
flangeThickness = 3;    // The thickness of the sleeve's flange
chamfer = 1;            // The width of the chamfer to add on the edges of the sleeve

spool = fetch(spools, spoolBrand);
holeDiameter = spool[HOLE];
depth = spool[DEPTH];

// Computes the dimensions of the sleeve for each part of the object.
sleeveHeight = depth + flangeThickness;
sleeveInnerHeight = sleeveHeight - chamfer * 2;
flangeDiameter = holeDiameter + flangeWidth * 2;
topDiameter = (holeDiameter - axleDiameter) / 2 - chamfer;
bottomDiameter = (flangeDiameter - axleDiameter) / 2 - chamfer;
flangeInnerWidth = flangeWidth - chamfer;
flangeInnerThickness = flangeThickness - chamfer * 2;
depthInner  = depth - chamfer;
startX = axleDiameter / 2 + chamfer;
startY = 0;

// Sets the minimum facet angle and size using the defined render mode.
applyMode(mode=renderMode) {
    rotate_extrude() {
        polygon(
            points=path([
                ["P", startX, startY],
                ["L", -chamfer, chamfer],
                ["V", sleeveInnerHeight],
                ["L", chamfer, chamfer],
                ["H", topDiameter],
                ["L", chamfer, -chamfer],
                ["V", -depthInner ],
                ["H", flangeInnerWidth],
                ["L", chamfer, -chamfer],
                ["V", -flangeInnerThickness],
                ["L", -chamfer, -chamfer],
                ["H", -bottomDiameter]
            ]),
            convexity=10
        );
    }
}
