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
 * A stand for the Blade Torrent 110 FPV.
 *
 * @author jsconan
 */

// As we need to use some shapes, use the right entry point of the library
use <../../lib/camelSCAD/shapes.scad>
include <../../lib/camelSCAD/core/constants.scad>

// We will render the object using the specifications of this mode
renderMode = MODE_PROD;

// Defines the constraints of the print
printResolution = 0.2;

// Defines the constraints of the object
batteryWidth = 35;
batteryHeight = 20;
coreWidth = 30;
armWidth = 11;
plateThickness = 3;
pillarThickness = 4;
pillarGroove = 1;
padding = plateThickness;
meshGap = 1;
meshCore = 5;
meshArm = [4, 2];
holeType = "plain"; // could be: false, "mesh", "plain"

// Defines the dimensions of the object
pillarWidth = roundBy(armWidth + padding, 5);
pillarHeight = roundBy(batteryHeight + plateThickness + 1, 5);
pillarEmbossThickness = pillarThickness + padding / 2;
pillarEmbossWidth = pillarWidth + padding / 2;
pillarInterval = batteryWidth + padding;
pillarGrooveWidth = armWidth + padding / 2;
plateWidth = pillarInterval + sqrt(pow(pillarEmbossWidth, 2) / 2) * 2;
plateRound = pillarThickness;
armLength = pythagore(plateWidth, plateWidth);
armOffset = pillarThickness;
armSize = [(armLength - coreWidth) / 2 + armOffset, pillarWidth];
armX = coreWidth / 2 - armOffset;

// Sets the minimum facet angle and size using the defined render mode.
// Displays a build box visualization to preview the printer area.
buildBox(mode=renderMode) {
    difference() {
        union() {
            // the base
            cylinder(d=coreWidth, h=plateThickness);

            // the arms with pillars
            repeatRotate(count=4) {
                // arm
                translateX(armX + armSize[0] / 2) {
                    linear_extrude(height=plateThickness, convexity=10)
                    difference() {
                        roundedRectangle(size=armSize, d=plateRound);
                        if (holeType) {
                            if (holeType == "mesh") {
                                mesh(size=armSize - [pillarThickness * 2, padding], count=meshArm, gap=meshGap, linear=true);
                            } else {
                                roundedRectangle(size=armSize - [(pillarThickness + padding) * 2, padding * 2], d=plateRound);
                            }
                        }
                    }
                }

                // pillar
                translateX(armX + armSize[0] - pillarThickness / 2) {
                    cushion(size=[pillarThickness, pillarWidth, pillarHeight + plateThickness], d=plateRound);
                    difference() {
                        translateZ(pillarHeight + pillarGroove) {
                            linear_extrude(height=plateThickness, convexity=10, scale=[pillarEmbossThickness / pillarThickness, pillarEmbossWidth / pillarWidth]) {
                                roundedRectangle(size=[pillarThickness, pillarWidth], d=plateRound);
                            }
                        }
                        translateZ(plateThickness + pillarHeight) {
                            box([pillarEmbossThickness * 2, pillarGrooveWidth, pillarGroove + ALIGN]);
                        }
                    }
                }
            }
        }

        // drill a hole on the base
        if (holeType) {
            negativeExtrude(plateThickness) {
                if (holeType == "mesh") {
                    rotateZ(45) {
                        mesh(coreWidth - padding * 2, count=meshCore, gap=meshGap, linear=false, pointy=true);
                    }
                } else {
                    circle(d=coreWidth - padding * 4);
                }
            }
        }
    }
}
