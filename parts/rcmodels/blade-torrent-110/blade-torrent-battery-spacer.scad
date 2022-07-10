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
 * A battery spacer for the Blade Torrent 110 FPV.
 *
 * @author jsconan
 */

// Import the project's setup.
include <../../../config/setup.scad>

// Defines the constraints of the object
coreWidth = 30;
armWidth = 11;
velcroThickness = 2.5;

velcroInUse = true;
velcroPassthrough = true;

screwHeadDiameter = 3.75;
screwHeadThickness = 1.7;
screwInterval = 25;

beltWidth = 11;
beltThickness = 1.4;
beltHoleInterval = 21;
beltHoleLength = 16;
beltHoleWidth = 3;

// Defines the dimensions of the object
velcroPlateSupport = layerHeight;
velcroPlateThickness = velcroThickness + (velcroPassthrough ? 0 : velcroPlateSupport);
plateOuterRound = armWidth / 2;
plateThickness = layerAligned(max(screwHeadThickness, velcroInUse ? velcroPlateThickness : 0));
plateOuterWidth = coreWidth + plateOuterRound;
plateInnerWidth = coreWidth;

armOuterX = plateOuterWidth / 2 - plateOuterRound / 2 + ALIGN;
armOuterY = plateOuterWidth / 2 + ALIGN;
armInnerX = plateInnerWidth / 2 - sqrt(pow(armWidth, 2) * 2) / 2;
armInnerY = plateInnerWidth / 2;

screwHoleDiameter = screwHeadDiameter + 1;
screwHoleIntervalX = screwInterval;
screwHoleIntervalY = screwInterval;

beltGrooveDepth = layerAligned(beltThickness);
beltGrooveLength = beltWidth;
beltGrooveWidth = (plateInnerWidth - beltHoleInterval) / 2;

meshSpace = 1;
meshCount = [3, 4];
meshLength = floor(plateInnerWidth - 2 * (plateThickness - meshSpace));
meshWidth = floor(beltHoleInterval - beltHoleWidth - 2 * (plateThickness - meshSpace));

velcroLength = floor(plateInnerWidth - 2 * screwHeadThickness);
velcroWidth = floor(beltHoleInterval - beltHoleWidth - 2 * screwHeadThickness);

echo("Plate thickness:", plateThickness);
echo("Velcro place:", [velcroLength, velcroWidth]);

// Sets the minimum facet angle and size using the defined render mode.
applyMode(mode=renderMode) {
    // build the plate
    difference() {
        // the raw plate
        cushion(l=plateOuterWidth, w=plateOuterWidth, h=plateThickness, d=plateOuterRound);

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
                polygon(
                    points = [
                        [armOuterX, armOuterY],
                        [-armOuterX, armOuterY],
                        [-armInnerX, armInnerY],
                        [armInnerX, armInnerY]
                    ],
                    convexity = 10
                );
            }
        }

        if (velcroInUse) {
            // place for the velcro
            translateZ(velcroPassthrough ? 0 : velcroPlateSupport) {
                negativeExtrude(plateThickness, direction=velcroPassthrough ? 2 : 1) {
                    roundedRectangle([velcroLength, velcroWidth], d=1);
                }
            }
        } else {
            // honeycomb mesh
            negativeExtrude(plateThickness) {
                rotateZ(90) {
                    mesh([meshWidth, meshLength], count=meshCount, gap=meshSpace, linear=true, pointy=false);
                }
            }
        }
    }
}
