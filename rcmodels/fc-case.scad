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
 * A case to enclose a flight controller in order to use it for simulator connection.
 *
 * @author jsconan
 * @version 0.2.0
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
bindPegDiameter = 3;
bindPosition = 8;
bindHeight = 3;
bindAngle = 45;
bindSwitchLength = 6;
bindSwitchWidth = 9;
bindSwitchDistance = nozzle;
ventThickness = 1;

// Defines the dimensions of the object.
caseWidth = frameWidth + thickness * 2;
placementDistribution = caseWidth + 5;
diagonal = pythagoras(frameWidth, frameWidth);
usbPlugOffset = diagonal / 2 - usbPosition;
bindPegOffset = diagonal / 2 - bindPosition;
bindPegHeight = bottomHeight - bindHeight;
bindSwitchOffset = bindPegOffset + bindPegDiameter / 2;
boxPocketChamfer = frameWidth - mountHoleDistance + mountHoleDiameter;
boxPocketHeight = bottomHeight - frameHeight;
mountPegHeight = bottomHeight + topHeight;

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

// Displays a build box visualization to preview the printer area.
buildBox(center=true);

// Sets the minimum facet angle and size using the defined render mode.
applyMode(mode=renderMode) {
    translateY(-placementDistribution / 2) {
        distributeGrid(intervalX=[0, placementDistribution, 0]) {
            // top box
            difference() {
                // box ouline
                fcCase(width=frameWidth, height=topHeight + thickness, corner=boxCorner, distance=thickness);
                // elephant feet counter measure
                translateZ(-printResolution) {
                    fcCaseRim(width=frameWidth, height=printResolution * 2, corner=boxCorner, rim=nozzle / 2, distance=thickness);
                }
                translateZ(thickness) {
                    // box hollow
                    chamferedBox([frameWidth, frameWidth, topHeight + thickness], chamfer=boxPocketChamfer);
                    // mount peg drills
                    translate(-[mountHoleDistance, mountHoleDistance, 0] / 2) {
                        repeat2D(countX=2, countY=2, intervalX=[mountHoleDistance, 0, 0], intervalY=[0, mountHoleDistance, 0]) {
                            cylinder(d=mountHoleDiameter, h=topHeight + thickness);
                        }
                    }
                }
                // vents
                translateZ(-thickness) {
                    circleVents(diameter=caseWidth / 2, thickness=ventThickness, height=topHeight);
                }
            }

            // bottom box
            union() {
                // mount pegs
                translate(-[mountHoleDistance, mountHoleDistance, 0] / 2) {
                    repeat2D(countX=2, countY=2, intervalX=[mountHoleDistance, 0, 0], intervalY=[0, mountHoleDistance, 0]) {
                        bullet([mountHoleDiameter, mountHoleDiameter, mountPegHeight], d=mountHoleDiameter / 2);
                    }
                }
                // bind switch peg
                rotateZ(bindAngle) {
                    translate([0, -bindPegOffset, thickness]) {
                        bullet([bindPegDiameter, bindPegDiameter, bindPegHeight], d=bindPegDiameter / 2);
                    }
                }
                difference() {
                    // box outline
                    fcCase(width=frameWidth, height=bottomHeight + thickness, corner=boxCorner, distance=thickness);
                    // elephant feet counter measure
                    translateZ(-printResolution) {
                        fcCaseRim(width=frameWidth, height=printResolution * 2, corner=boxCorner, rim=nozzle / 2, distance=thickness);
                    }
                    // lower box hollow, will be under the FC
                    translateZ(thickness) {
                        chamferedBox([frameWidth, frameWidth, boxPocketHeight], chamfer=boxPocketChamfer);
                    }
                    // upper box hollow, will be at the FC level
                    translateZ(thickness + boxPocketHeight) {
                        fcCase(width=frameWidth, height=bottomHeight, corner=boxCorner);
                    }
                    translateZ(-thickness) {
                        // vents
                        circleVents(diameter=caseWidth / 2, thickness=ventThickness, height=bottomHeight);
                        // drill for the USB plug
                        rotateZ(usbAngle) {
                            translateY(usbPlugOffset) {
                                box([usbWidth, usbThickness, bottomHeight]);
                            }
                        }
                        // bind switch
                        rotateZ(bindAngle) {
                            translateY(-bindSwitchOffset) {
                                negativeExtrude(height=bottomHeight) {
                                    polygon(
                                        points = path([
                                            ["P", bindSwitchWidth / 2, bindSwitchLength],
                                            ["C", bindSwitchDistance / 2, 180, 0],
                                            ["C", [bindSwitchWidth / 2 + bindSwitchDistance, bindSwitchLength + bindSwitchDistance], 360, 180],
                                            ["C", bindSwitchDistance / 2, 180, 0],
                                            ["C", [bindSwitchWidth / 2, bindSwitchLength], 180, 360],
                                        ]),
                                        convexity = 10
                                    );
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
