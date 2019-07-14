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
 * A case to enclose a flight controller in order to use it for simulator connection.
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
frameWidth = 30;
frameHeight = 2.5;
mountHoleDiameter = 3;
mountHoleDistance = 26;
boxCorner = 1;
bottomHeight = 6;
topHeight = 3;
thickness = .8;
usbWidth = 7.5;
usbThickness = 2.6;
usbPosition = 8.2;
usbAngle = 45;
ventThickness = 1;

// Defines the dimensions of the object.
caseWidth = frameWidth + thickness * 2;
diagonal = pythagoras(frameWidth, frameWidth);
usbOffset = diagonal / 2 - usbPosition;
boxChamfer = frameWidth - mountHoleDistance + mountHoleDiameter;
boxPocket = bottomHeight - frameHeight;
distribution = caseWidth + 5;
pillarHeight = bottomHeight + topHeight;

/**
 * Draws the case shape
 * @param Number width
 * @param Number corner
 * @param Number distance
 */
module fcCaseShape(width, corner, distance = 0) {
    polygon(
        points = outline(
            points = drawRoundedRectangle(size=width, r=corner),
            distance = distance
        ),
        convexity = 10
    );
}

/**
 * Draws the case
 * @param Number width
 * @param Number height
 * @param Number corner
 * @param Number distance
 */
module fcCase(width, height, corner, distance = 0) {
    negativeExtrude(height=height) {
        fcCaseShape(width=width, corner=corner, distance=distance);
    }
}

/**
 * Draws a case rim
 * @param Number width
 * @param Number height
 * @param Number corner
 * @param Number rim
 * @param Number distance
 */
module fcCaseRim(width, height, corner, rim, distance = 0) {
    negativeExtrude(height=height) {
        difference() {
            fcCaseShape(width=width, corner=corner, distance=distance + rim);
            fcCaseShape(width=width, corner=corner, distance=distance - rim);
        }
    }
}

/**
 * Draws the case vents
 * @param Number diameter
 * @param Number thickness
 * @param Number height
 */
module circleVents(diameter, thickness, height) {
    interval = thickness + roundBy(thickness, nozzle);
    radius = diameter / 2;
    count = floor(radius / interval);
    rotateZ(-45) {
        repeatMirror() {
            for(i = [0 : count]) {
                offset = (i + .5) * interval;
                translateX(offset) {
                    slot([thickness, 2 * pythagoras(b=offset, c=radius), height], d=thickness);
                }
            }
        }
    }
}

// Sets the minimum facet angle and size using the defined render mode.
// Displays a build box visualization to preview the printer area.
buildBox(mode=renderMode) {
    translateY(-distribution / 2) {
        distributeGrid(intervalX=[0, distribution, 0]) {
            // top box
            difference() {
                fcCase(width=frameWidth, height=topHeight + thickness, corner=boxCorner, distance=thickness);
                translateZ(-printResolution) {
                    fcCaseRim(width=frameWidth, height=printResolution * 2, corner=boxCorner, rim=nozzle / 2, distance=thickness);
                }
                translateZ(thickness) {
                    chamferedBox([frameWidth, frameWidth, topHeight + thickness], chamfer=boxChamfer);
                    translate(-[mountHoleDistance, mountHoleDistance, 0] / 2) {
                        repeat2D(countX=2, countY=2, intervalX=[mountHoleDistance, 0, 0], intervalY=[0, mountHoleDistance, 0]) {
                            cylinder(d=mountHoleDiameter, h=topHeight + thickness);
                        }
                    }
                }
                translateZ(-thickness) {
                    circleVents(diameter=caseWidth / 2, thickness=ventThickness, height=topHeight);
                }
            }

            // bottom box
            union() {
                translate(-[mountHoleDistance, mountHoleDistance, 0] / 2) {
                    repeat2D(countX=2, countY=2, intervalX=[mountHoleDistance, 0, 0], intervalY=[0, mountHoleDistance, 0]) {
                        bullet([mountHoleDiameter, mountHoleDiameter, pillarHeight], d=mountHoleDiameter / 2);
                    }
                }
                difference() {
                    fcCase(width=frameWidth, height=bottomHeight + thickness, corner=boxCorner, distance=thickness);
                    translateZ(-printResolution) {
                        fcCaseRim(width=frameWidth, height=printResolution * 2, corner=boxCorner, rim=nozzle / 2, distance=thickness);
                    }
                    translateZ(thickness) {
                        chamferedBox([frameWidth, frameWidth, boxPocket], chamfer=boxChamfer);
                    }
                    translateZ(thickness + boxPocket) {
                        fcCase(width=frameWidth, height=bottomHeight, corner=boxCorner);
                    }
                    translateZ(-thickness) {
                        circleVents(diameter=caseWidth / 2, thickness=ventThickness, height=bottomHeight);
                        rotateZ(usbAngle) {
                            translateY(usbOffset) {
                                box([usbWidth, usbThickness, bottomHeight]);
                            }
                        }
                    }
                }
            }
        }
    }
}
