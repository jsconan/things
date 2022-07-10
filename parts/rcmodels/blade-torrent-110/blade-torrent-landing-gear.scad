/**
 * @license
 * GPLv3 License
 *
 * Copyright (c) 2017-2022 Jean-Sebastien CONAN
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
 * A landing gear for the Blade Torrent 110 FPV.
 * This thing is very experimental.
 * For now the legs break each time the quad is landing or just flying too close to the ground...
 *
 * @author jsconan
 */

// Import the project's setup.
include <../../../config/setup.scad>

// Defines the constraints of the object
coreWidth = 30;
armWidth = 11;
gearAngle = 10;

batteryLength = 56;
batteryWidth = 33;
batteryHeight = 17;

screwHeadDiameter = 3.75;
screwHeadThickness = 1.7;
screwInterval = 25.5;

beltWidth = 11;
beltThickness = 1.2;
beltHoleInterval = 21;
beltHoleLength = 16;
beltHoleWidth = 3;

// Defines the dimensions of the object
legSkew = sin(gearAngle);
legHeight = layerAligned(batteryHeight + screwHeadThickness + 10);
legDiameterBase = armWidth / 2;
legDiameterEdge = legDiameterBase / 2;
legInterval = max(batteryWidth, coreWidth) + armWidth;

plateThickness = layerAligned(screwHeadThickness);
plateOuterWidth = legInterval + legDiameterBase;
plateInnerWidth = coreWidth;
plateArmWidth = armWidth;
plateArmPos = sqrt(pow(plateArmWidth, 2) * 2) / 2;

screwHoleDiameter = screwHeadDiameter + 1;
screwHoleIntervalX = screwInterval;
screwHoleIntervalY = screwInterval;

beltGrooveDepth = layerAligned(beltThickness);
beltGrooveLength = beltWidth;
beltGrooveWidth = (plateInnerWidth - beltHoleInterval) / 2;

meshSpace = 1;
meshCountX = 4;
meshCountY = 3;
meshLength = floor(plateInnerWidth - 2 * plateThickness);
meshWidth = floor(beltHoleInterval - beltHoleWidth - 2 * plateThickness);

// Sets the minimum facet angle and size using the defined render mode.
applyMode(mode=renderMode) {
    // build the plate
    difference() {
        // the raw plate
        cushion(l=plateOuterWidth, w=plateOuterWidth, h=plateThickness, d=legDiameterBase);

        // the belt groove
        repeatMirror(count=2, axis=[0, 1, 0]) {
            translate([0, (plateInnerWidth - beltGrooveWidth + beltHoleWidth / 2) / 2, plateThickness]) {
                rotateX(90) {
                    translateZ(-beltGrooveWidth / 2) {
                        cushion(l=beltGrooveLength + beltGrooveDepth * 2, h=beltGrooveWidth + ALIGN2, w=beltGrooveDepth * 2, r=beltGrooveDepth);
                    }
                }
            }
        }

        // the holes that drills the plate
        negativeExtrude(plateThickness) {
            // holes for the screws
            translate(-[screwHoleIntervalX, screwHoleIntervalY, 0] / 2) {
                repeat2D(countX=2,
                         countY=2,
                         intervalX=[screwHoleIntervalX, 0, 0],
                         intervalY=[0, screwHoleIntervalY, 0]) {
                        circle(d=screwHoleDiameter);
                    }
            }

            // holes for the battery belt
            rotateZ(90) {
                translateX(-beltHoleInterval / 2) {
                    repeat(count=2, intervalX=beltHoleInterval) {
                        stadium(h=beltHoleLength, d=beltHoleWidth);
                    }
                }
            }

            // cut the arms
            repeatRotate(count=4) {
                outerX = plateOuterWidth / 2 - legDiameterBase / 2 + ALIGN;
                outerY = plateOuterWidth / 2 + ALIGN;
                innerX = plateInnerWidth / 2 - plateArmPos;
                innerY = plateInnerWidth / 2;

                polygon(
                    points = [
                        [outerX, outerY],
                        [-outerX, outerY],
                        [-innerX, innerY],
                        [innerX, innerY]
                    ],
                    convexity = 10
                );
            }

            // drill the mesh
            rotateZ(90) {
                mesh([meshWidth, meshLength], count=[meshCountY, meshCountX], gap=meshSpace);
            }
        }
    }
    // add the legs
    repeatMirror2D() {
        translate([legInterval, legInterval, 0] / 2) {
            transform(scaleXZ=legSkew, scaleYZ=legSkew) {
                cylinder(d1=legDiameterBase, d2=legDiameterEdge, h=legHeight);
            }
        }
    }
}
