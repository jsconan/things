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
 * A camera holder to mount on a TinyWhoop quadcopter.
 * Default dimensions are for a Blade Inductrix and a CM275T camera.
 *
 * @author jsconan
 */

// As we need to use some shapes, use the right entry point of the library
use <../../lib/camelSCAD/shapes.scad>
include <../../lib/camelSCAD/core/constants.scad>

// We will render the object using the specifications of this mode
renderMode = MODE_PROD;

// Defines the dimensions of the object
screwInterval = 25.5;
screwDiameter =  2.0;

motorInterval = 46.0;
ductDiameter  = 37.0;
ductInterval  = pythagore(motorInterval, motorInterval);

plateThickness =  0.6;
plateRound     =  1.0;
plateWidth     = 30.0;
plateDiag      = pythagore(plateWidth, plateWidth);

cameraLength     = 15.0;
cameraWidth      =  8.0;

cameraLensWidth  =  9.0;
cameraLensX      =  0.5;
cameraLensY      =  -cameraWidth / 2;
cameraLensZ      =  6.0 - cameraLensWidth / 2;

cameraFrontWidth =  3.0;
cameraFrontX     =  -(cameraWidth + cameraFrontWidth - ALIGN2) / 2;
cameraFrontY     =  -cameraWidth / 2;
cameraFrontZ     =  3.0;

cameraBackWidth  =  5.0;
cameraBackX      =  -(cameraLength - cameraBackWidth) / 2;
cameraBackY      =  cameraWidth / 2;

holderThickness =  0.5;
holderAngle     = 20.0;
holderHeight    =  5.0;
holderEdgeWidth =  1.5;
holderLength    = cameraLength + 2 * holderThickness;
holderWidth     = cameraWidth + 2 * holderThickness;
holderSkew      = sin(holderAngle);

// simple rounded triangle as half a square
module triangle(side) {
    offset(r=plateRound) {
        side = side - plateRound;
        polygon([
            [-side, side / 2],
            [side, side / 2],
            [0, -side / 2]
        ]);
    }
}

// Sets the minimum facet angle and size using the defined render mode.
// Displays a build box visualization to preview the printer area.
buildBox(mode=renderMode) {
    difference() {
        union() {
            // Draws the plate
            rotateZ(45) {
                difference() {
                    cushion([plateWidth, plateWidth, plateThickness], r=plateRound);
                    repeatRotate(count=4) {
                        translate([-screwInterval, -screwInterval, -ALIGN2] / 2) {
                            cylinder(d=screwDiameter, h=plateThickness + ALIGN2);
                        }
                        translate([0, -ductInterval, -ALIGN2] / 2) {
                            cylinder(d=ductDiameter, h=plateThickness + ALIGN2);
                        }
                    }
                }
            }

            // Draws the camera holder
            transform(translateY=-holderWidth / 2, translateZ=plateThickness, scaleYZ=holderSkew) {
                difference() {
                    box([holderLength, holderWidth, holderHeight]);

                    // hole for the lens of the camera
                    translate([cameraLensX, cameraLensY - holderThickness / 2, cameraLensZ + holderSkew]) {
                        box([cameraLensWidth, holderThickness + ALIGN, holderHeight + ALIGN]);
                    }

                    // hole for the front of the camera
                    translate([cameraFrontX, cameraFrontY - holderThickness / 2, cameraFrontZ + holderSkew]) {
                        box([cameraFrontWidth, holderThickness + ALIGN, holderHeight + ALIGN]);
                    }

                    // hole for the back of the camera
                    translate([cameraBackX, cameraBackY + holderThickness / 2, -ALIGN]) {
                        box([cameraBackWidth, holderThickness + ALIGN, holderHeight + ALIGN2]);
                    }

                    // hole for the camera
                    transform(scaleZY=-holderSkew / 2, translateZ=cos(holderAngle)) {
                        box([cameraLength, cameraWidth, holderHeight + ALIGN]);
                    }
                }
            }
        }

        // passthrough hole on the camera holder
        transform(translateY=-holderWidth / 2, translateZ=-ALIGN, scaleYZ=holderSkew) {
            translateZ(-ALIGN) {
                box([cameraLength - holderEdgeWidth * 2, cameraWidth - holderEdgeWidth * 2, holderHeight]);
            }
        }
        repeatMirror(count=2) {
            translate([plateDiag / 8, plateDiag / 8, -ALIGN]) {
                cushion([plateDiag / 6, plateDiag / 6, plateThickness + ALIGN2], r=plateRound);
            }
        }

        // triangle holes
        repeatRotate(count=4) {
            translate([0, -plateDiag / 3.25, -ALIGN]) {
                linear_extrude(height=plateThickness + ALIGN2) {
                    triangle(plateWidth / 6);
                }
            }
        }
    }
}
