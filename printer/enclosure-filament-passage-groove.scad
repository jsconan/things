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
 * A filament passage groove for the LACK enclosure.
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
printResolution = 0.2;  // the target layer height
nozzle = 0.4;           // the size of the print nozzle
wallDistance = 0.1;     // the distance between the walls of two objects

// Defines the constraints of the object.
grooveLength = 200;
grooveWidth = 12;
mainWallThickness = nozzle * 3;
capWallThickness = nozzle * 2;
boardHeight = 50;
flangeWidth = 20;
flangeThickness = printResolution * 8;
capFlange = 8;
capHeight = 15;

module passageGroove(size, flange, thickness, wall, distance=0) {
    hole = vector3D(size) + 2 * [distance, distance, 0];
    tube = vadd(hole, wall * 2);
    outer = vadd(hole, flange * 2);
    height = hole[2] + thickness;
    holeBevel = vadd(hole, 2 * thickness);
    outerBevel = vsub(outer, 2 * thickness);

    difference() {
        union() {
            linear_extrude(height=thickness, scale=vector2D(vdiv(outer, outerBevel))) {
                stadium(outerBevel);
            }
            slot(size=tube, h=height);
        }
        negativeExtrude(height=thickness, scale=vector2D(vdiv(hole, holeBevel))) {
            stadium(holeBevel);
        }
        negativeExtrude(height=printResolution) {
            difference() {
                stadium(outer);
                stadium(vsub(outerBevel, 2 * nozzle));
            }
        }
        negativeExtrude(height=height) {
            stadium(hole);
        }
    }
}


// Sets the minimum facet angle and size using the defined render mode.
// Displays a build box visualization to preview the printer area.
applyMode(mode=renderMode) {
    // Uncomment the next line to cut a sample from the object
    //sample(size=[DEFAULT_BUILD_PLATE_SIZE, DEFAULT_BUILD_PLATE_SIZE, 5], offset=[0, 0, 0])
    union() {
        rotateZ(90) {
            translateX(grooveWidth + flangeWidth) {
                passageGroove(
                    size=[grooveWidth, grooveLength, boardHeight],
                    flange=flangeWidth,
                    thickness=flangeThickness,
                    wall=mainWallThickness
                );
            }
            translateX(-grooveWidth - flangeWidth) {
                passageGroove(
                    size=[grooveWidth, grooveLength, capHeight],
                    flange=capFlange,
                    thickness=flangeThickness,
                    wall=capWallThickness,
                    distance=-capWallThickness
                );
            }
        }
    }
}
