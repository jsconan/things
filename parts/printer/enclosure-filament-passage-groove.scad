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
 * A filament passage groove for the LACK enclosure.
 *
 * @author jsconan
 */

// Import the project's setup.
include <../../config/setup.scad>

// Defines the constraints of the object.
grooveLength = 200;
grooveWidth = 12;
mainWallThickness = shells(3);
capWallThickness = shells(2);
boardHeight = 50;
flangeWidth = 20;
flangeThickness = layers(8);
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
        negativeExtrude(height=layerHeight) {
            difference() {
                stadium(outer);
                stadium(vsub(outerBevel, shells(2)));
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
