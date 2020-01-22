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
 * A fastener to attach a cover door to a fridge
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

/**
 * Draws the shape of a fastener to attach a cover door to a fridge.
 * @param Number screwCount - The number of screws to attach the fastener
 * @param Number screwDiameter - The diameter of each screw
 * @param Number screwHeadDiameter - The diameter for the room reserved for a screw head
 * @param Number screwThickness - The thickness of the plate the screw must link
 * @param Number screwInterval - The disrance between two screws
 * @param Number screwPaddingX - The horizontal padding around screws
 * @param Number screwPaddingY - The vertical padding around screws
 * @param Number flangeWidth - The width of the flange from the border of the fastener to the border of the screwed plate
 * @param Number flangeThickness - The thickness of the flange
 * @param Number spacerSide - The side where to place the spacer: -1=left, 1=right
 * @param Number spacerLength - The length of the optional spacer area to add
 * @param Number spacerThickness - The thickness of the optional spacer area to add
 * @param Number thickness - The overall thickness of the fastener (the distance between the fridge and the cover door)
 * @param Number roundCorner - The radius of the rounded corners
 */
module fridgeDoorFastener(
    screwCount,
    screwDiameter,
    screwHeadDiameter,
    screwThickness,
    screwInterval,
    screwPaddingX,
    screwPaddingY,
    flangeWidth,
    flangeThickness,
    spacerSide,
    spacerLength,
    spacerThickness,
    thickness,
    roundCorner
) {
    intervalLength = screwInterval  * (screwCount - 1);
    bodyWidth = screwDiameter + screwPaddingY * 2;
    length = intervalLength + screwDiameter + screwPaddingX * 2;
    width = bodyWidth + flangeWidth;
    height = thickness + spacerThickness;
    screwHeadHole = height - screwThickness - spacerThickness;
    spacerHole = length - abs(spacerLength);

    echo("Overall size:", length, width, height);

    difference() {
        // the main body, including the flange
        translateY(flangeWidth / 2) {
            cushion(size=[length, width, height], r=roundCorner);
        }

        // drill the flange
        translate([-length, (width - flangeWidth) / 2 + flangeWidth, height + flangeThickness]) {
            rotateY(90) {
                cushion(size=[height, flangeWidth, length] * 2, r=1);
            }
        }

        // dril the screw holes
        translateX(-intervalLength / 2) {
            repeat(count=screwCount, interval=[screwInterval, 0, 0]) {
                // head
                translateZ(-ALIGN) {
                    cylinder(d=screwHeadDiameter, h=screwHeadHole + ALIGN);

                }
                // body
                translateZ(screwThickness) {
                    cylinder(d=screwDiameter, h=height);
                }
            }
        }

        // optional spacer
        translate([spacerSide * (spacerLength + ALIGN) / 2, 0, height - spacerThickness]) {
            box([spacerHole + ALIGN2, width, spacerThickness + ALIGN]);

            translateX(-spacerSide * (spacerHole + bodyWidth + ALIGN2) / 2) {
                negativeExtrude(height=spacerThickness + ALIGN2) {
                    difference() {
                        translateX(spacerSide * bodyWidth / 4 - ALIGN) {
                            rectangle([bodyWidth / 2 + ALIGN, bodyWidth + ALIGN2]);
                        }
                        circle(d=bodyWidth);
                    }
                }
            }
        }
    }
}

// Defines the constraints of the object.
roundCorner = 3;            // The radius of the rounded corners
screwCount = 3;             // The number of screws to attach the fastener
screwDiameter = 4;          // The diameter of each screw
screwHeadDiameter = 10;     // The diameter for the room reserved for a screw head
screwThickness = 3;         // The thickness of the plate the screw must link
screwInterval = 37.5;       // The disrance between two screws
screwPaddingX = 13.5;       // The horizontal padding around screws
screwPaddingY = 5.5;        // The vertical padding around screws
flangeWidth = 10;           // The width of the flange from the border of the fastener to the border of the screwed plate
flangeThickness = 2;        // The thickness of the flange
models = [
    [
        ["thickness", 18],          // The overall thickness of the fastener (the distance between the fridge and the cover door)
        ["spacerSide", 0],          // The side where to place the spacer: -1=left, 1=right
        ["spacerLength", 0],        // The length of the optional spacer area to add
        ["spacerThickness", 0],     // The thickness of the optional spacer area to add
    ],
    [
        ["thickness", 13],          // The overall thickness of the fastener (the distance between the fridge and the cover door)
        ["spacerSide", -1],         // The side where to place the spacer: -1=left, 1=right
        ["spacerLength", 55],       // The length of the optional spacer area to add
        ["spacerThickness", 4.4],   // The thickness of the optional spacer area to add
    ]
];

// Sets the minimum facet angle and size using the defined render mode.
// Displays a build box visualization to preview the printer area.
applyMode(mode=renderMode) {
    // Uncomment the next line to cut a sample from the object
    //sample(size=[DEFAULT_BUILD_PLATE_SIZE, DEFAULT_BUILD_PLATE_SIZE, 5], offset=[0, 0, 0])
    interval = screwDiameter + screwPaddingY * 3 + flangeWidth;
    count = len(models) - 1;
    for(i = [0 : count]) {
        model = models[i];
        translateY(-(count * interval / 2) + (interval * i)) {
            fridgeDoorFastener(
                screwCount = screwCount,
                screwDiameter = screwDiameter,
                screwHeadDiameter = screwHeadDiameter,
                screwThickness = screwThickness,
                screwInterval = screwInterval,
                screwPaddingX = screwPaddingX,
                screwPaddingY = screwPaddingY,
                flangeWidth = flangeWidth,
                flangeThickness = flangeThickness,
                spacerSide = fetch(model, "spacerSide")[1],
                spacerLength = fetch(model, "spacerLength")[1],
                spacerThickness = fetch(model, "spacerThickness")[1],
                thickness = fetch(model, "thickness")[1],
                roundCorner = roundCorner
            );
        }
    }
}
