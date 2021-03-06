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
 * A spool holder that mounts on a cylindric food dehydratator.
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
printResolution = 0.2;

// Defines the constraints of the object.
mountDiameter = 79;
mountDepth = 5;
mountWall = 5;

plateThickness = 5;
plateRidgeWidth = 1;
plateRidgeHeight = .5;
plateRidgeCount = 4;

spoolHoleDiameter = 50;
spoolHoleHeight = 30;
spoolHoleChamfer = 1;
spoolHoleRidgeWidth = 1;
spoolHoleRidgeHeight = .5;
spoolHoleRidgeCount = 6;

// Defines the dimensions of the object.
plateHeight = roundBy(plateThickness + mountDepth - plateRidgeHeight, printResolution);
plateDiameter = mountDiameter + mountWall * 2;
plateBrim = (plateDiameter - spoolHoleDiameter) / 2;
plateRidgeInterval = plateBrim / plateRidgeCount - plateRidgeWidth;
plateRidgeX = plateRidgeWidth / 2 * cos(60);
plateRidgeY = plateRidgeHeight;

spoolHoleInnerDiameter = spoolHoleDiameter - spoolHoleRidgeHeight * 2;
spoolHoleRidgeInterval = (spoolHoleHeight - spoolHoleRidgeWidth) / spoolHoleRidgeCount - spoolHoleRidgeWidth;
spoolHoleRidgeX = spoolHoleRidgeHeight;
spoolHoleRidgeY = spoolHoleRidgeWidth / 2 * cos(60);

// Sets the minimum facet angle and size using the defined render mode.
// Displays a build box visualization to preview the printer area.
buildBox(mode=renderMode) {
    //sample(size=vadd([plateDiameter, plateDiameter, 8], ALIGN2), offset=[0, 0, -ALIGN])
    //sample(size=vadd([plateDiameter, plateDiameter, 8], ALIGN2), offset=[0, 0, plateHeight+spoolHoleHeight-8-ALIGN])
    rotate_extrude() {
        polygon(
            points=path(concat([
                // mount side
                ["P", 0, mountDepth],
                ["H", mountDiameter / 2],
                ["V", -mountDepth],
                ["H", mountWall],

                // plate side
                ["V", plateHeight]
            ], flatten([
                for(i=[0:plateRidgeCount - 1]) [
                    ["L", -plateRidgeInterval * and(i, 1), 0],
                    ["L", - plateRidgeX, plateRidgeY],
                    ["H", - plateRidgeWidth + plateRidgeX * 2],
                    ["L", - plateRidgeX, -plateRidgeY]
                ]
            ]), [
                // spool hole side
                ["P", spoolHoleInnerDiameter / 2, plateHeight],
            ], flatten([
                for(i=[1:spoolHoleRidgeCount]) [
                    ["L", 0, spoolHoleRidgeInterval * and(i, 1)],
                    ["L", spoolHoleRidgeX, spoolHoleRidgeY],
                    ["V", spoolHoleRidgeWidth - spoolHoleRidgeY * 2],
                    ["L", -spoolHoleRidgeX, spoolHoleRidgeY],
                ]
            ]), [
                ["L", -spoolHoleChamfer, spoolHoleChamfer],
                ["H", -spoolHoleInnerDiameter / 2 + spoolHoleChamfer],
            ])),
            convexity=10
        );
    }
}
