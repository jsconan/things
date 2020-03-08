/**
 * @license
 * GPLv3 License
 *
 * Copyright (c) 2019-2020 Jean-Sebastien CONAN
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
holeDiameter = 62.7;    // the diameter of the hole in the dehydratator plate
holeDepth = 6;          // the depth in the dehydratator plate
flange = 4;             // the width of the flange that will overflow the hole
edge = 2;               // the thickness of the flange edge
height = 10;            // the height of a spool holder

plateRidgeWidth = 1;    // the width of a ridge on the plates
plateRidgeHeight = .4;  // the height of a ridge on the plates
plateRidgeCount = 3;    // the number of ridges on the plates

wallRidgeWidth = 1;    // the width of a ridge on the walls
wallRidgeHeight = .4;  // the height of a ridge on the walls
wallRidgeCount = 2;    // the number of ridges on the walls

spoolDiameters = [50, 26];  // diameters of each spool to support

// Defines the dimensions of the object.
plateDiameter = holeDiameter + flange * 2;
diameters = unshift([ for (i = [0 : len(spoolDiameters) - 1]) spoolDiameters[i] - wallRidgeHeight * 2 ], plateDiameter);
count = len(diameters);
heights = [ for (i = [0 : count - 1]) i * height + holeDepth + flange + edge ];
brims = [ for (i = [1 : count - 1]) (diameters[i - 1] - diameters[i]) / 2 ];
intervalX = [ for (i = [0 : count - 1]) brims[i] / plateRidgeCount - plateRidgeWidth ];
intervalY = height / wallRidgeCount - wallRidgeWidth;

plateRidgeX = plateRidgeWidth / 2 * cos(60);
plateRidgeY = plateRidgeHeight;
wallRidgeX = wallRidgeHeight;
wallRidgeY = wallRidgeWidth / 2 * cos(60);

// Displays a build box visualization to preview the printer area.
buildBox(center=true);

// Sets the minimum facet angle and size using the defined render mode.
applyMode(mode=renderMode) {
    rotate_extrude() {
        polygon(
            points=path(concat([
                ["P", 0, 0],
                ["H", holeDiameter / 2],
                ["V", holeDepth],
                ["L", flange, flange],
                ["V", edge],
                ["N", [ for(i = [0 : count - 2])
                    ["N", [
                        ["R", plateRidgeCount, [
                            ["L", -plateRidgeX, plateRidgeY],
                            ["H", -plateRidgeWidth + plateRidgeX * 2],
                            ["L", -plateRidgeX, -plateRidgeY],
                            ["L", -intervalX[i], 0]
                        ]],
                        ["P", diameters[i + 1] / 2, heights[i]],
                        ["R", wallRidgeCount, [
                            ["L", 0, intervalY],
                            ["L", wallRidgeX, wallRidgeY],
                            ["V", wallRidgeWidth - wallRidgeY * 2],
                            ["L", -wallRidgeX, wallRidgeY],
                        ]]
                    ]]
                ]],
                ["P", 0, heights[count -1]]
            ])),
            convexity=10
        );
    }
}
