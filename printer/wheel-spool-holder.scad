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
 * A spool holder that will be pluggable on the wheels of the adjustable
 * spool holder from the LACK enclosure cabinet.
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
wheelWidth = 4.4;
wheelDiameter = 24.5;
wheelDistance = 80;
wheelPadding = 5;
spoolWidth = 100;
spoolDiameter = 200;
spoolHoleDiameter = 50;
axleDiameter = 25;
axleGrooveDepth = 3;
axleEdge = 1;

// Defines the dimensions of the object.
axleGrooveDiameter = axleDiameter - axleGrooveDepth * 2;
axleLength = (axleEdge + wheelWidth + axleGrooveDepth * 2) * 2 + wheelDistance;
spoolHeight = (spoolDiameter + spoolHoleDiameter) / 2;
spoolHolderLegWidth = wheelDistance + wheelDiameter + wheelPadding * 2;
spoolHolderLegheight = spoolHeight + (axleGrooveDiameter + wheelDiameter) * 3 / 4 + wheelPadding * 2;

/**
 * Axle for the spool holder.
 * @param Number diameter - the axle diameter
 * @param Number interval - the interval between the legs
 * @param Number groove - the width of the groove that will receive a leg
 * @param Number depth - the depth of the groove that will receive a leg
 * @param Number edge - the edge of the axle
 */
module spoolHolderAxle(diameter, interval, groove, depth=5, edge=1) {
    rotate_extrude(angle = 360, convexity = 10) {
        polygon(
            points=path([
                ["P", 0, 0],
                ["H", diameter / 2],
                ["V", edge],
                ["L", -depth, depth],
                ["V", groove],
                ["L", depth, depth],
                ["V", interval],
                ["L", -depth, depth],
                ["V", groove],
                ["L", depth, depth],
                ["V", edge],
                ["H", -diameter / 2, 0],
            ]),
            convexity = 10
        );
    }
}

/**
 * Leg for the spool holder.
 * @param Number wheelDiameter - the diameter of a wheel on which the leg should stand
 * @param Number wheelDistance - the distance between the wheels on which the leg should stand
 * @param Number axleDiameter - the diameter of the axle that will fit on the legs
 * @param Number axleDistance - the distance between the axle and the wheels
 * @param Number width - The thickness of a leg
 * @param Number padding - The padding around the wheels
 */
module spoolHolderLeg(wheelDiameter, wheelDistance, axleDiameter, axleDistance, width, padding) {
    roundRadius = padding / 4;
    overflow = padding / 2;
    wheelRadius = wheelDiameter / 2;
    axleRadius = axleDiameter / 2;
    armWidth = wheelDiameter + padding * 2;
    outerWidth = wheelDistance + wheelDiameter + padding * 2;
    outerHeight = axleDistance + (axleDiameter + wheelDiameter) * 3 / 4 + padding * 2;
    quarter = axleDistance / 4;
    hollow = axleDistance * 3 / 5;

    translateY(-axleDistance / 2) {
        %union() {
            translateY(wheelDistance / 2) rectangle(wheelDistance);
            translateX(-wheelDistance / 2) repeat(interval=[wheelDistance]) circle(d=wheelDiameter);
            translateY(axleDistance / 2) rectangle(axleDistance);
            translateY(axleDistance) circle(d=axleDiameter);
        }
        negativeExtrude(width) {
            repeatMirror() {
                difference() {
                    polygon(
                        points=path([
                            ["P", outerWidth / 2, 0],
                            ["V", -overflow],
                            ["C", roundRadius, 360, 270],
                            ["H", -overflow],
                            ["C", roundRadius, 270, 180],
                            ["V", overflow],
                            ["C", wheelRadius, 0, 180],
                            ["V", -overflow],
                            ["C", roundRadius, 360, 270],
                            ["H", -overflow],
                            ["C", roundRadius, 270, 180],
                            ["V", overflow],
                            ["C", [outerWidth / 2 - armWidth, quarter * 3], 0, 90],
                            ["V", quarter - axleRadius],
                            ["C", axleRadius, 270, 360],
                            ["V", overflow],
                            ["C", roundRadius, 180, 90],
                            ["C", [(outerWidth - axleDiameter - overflow) / 2, axleDistance], 90, 0]
                        ]),
                        convexity = 10
                    );
                    polygon(
                        points=path([
                            ["P", (wheelDistance + wheelRadius) / 2, quarter],
                            ["C", [wheelDiameter, hollow], 0, 90],
                            ["C", [wheelDiameter, hollow], 180, 270],
                        ]),
                        convexity = 10
                    );
                }
            }
        }
    }
}

// Displays a build box visualization to preview the printer area.
buildBox(center=true);

// Sets the minimum facet angle and size using the defined render mode.
applyMode(mode=renderMode) {
    // Uncomment the next line to cut a sample from the object
    //sample(size=[DEFAULT_BUILD_PLATE_SIZE, DEFAULT_BUILD_PLATE_SIZE, 5], offset=[0, 0, 0])
    union() {
        translateY(spoolHolderLegheight / 4) {
            spoolHolderAxle(
                diameter = axleDiameter,
                interval = spoolWidth + wheelPadding * 2,
                groove = wheelWidth,
                depth = axleGrooveDepth,
                edge = axleEdge
            );
        }

        translateX(-(spoolHolderLegWidth + wheelPadding) / 2) {
            repeat(interval = [spoolHolderLegWidth + wheelPadding, 0, 0]) {
                spoolHolderLeg(
                    wheelDiameter = wheelDiameter,
                    wheelDistance = wheelDistance,
                    axleDiameter = axleGrooveDiameter,
                    axleDistance = spoolHeight,
                    width = wheelWidth,
                    padding = wheelPadding
                );
            }
        }
    }
}
