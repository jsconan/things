/**
 * @license
 * GPLv3 License
 *
 * Copyright (c) 2018-2019 Jean-Sebastien CONAN
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
 * A wires separaror.
 *
 * @author jsconan
 * @version 0.1.0
 */

// As we need to use some shapes, use the right entry point of the library
use <../lib/camelSCAD/shapes.scad>
include <../lib/camelSCAD/core/constants.scad>

// We will render the object using the specifications of this mode
renderMode = MODE_PROD;

// Defines the constraints and the dimensions of the object
width = 10;
flangeHeight = 10;
padding = 3;
wireInterval = 70;
wireDiameter = 2.95;
aperturePercent = 95;
gouged = true;
flat = false;

// Computes the constrained dimensions of the object
plateLength = wireInterval + wireDiameter + 2 * padding;
plateWidth = width;
plateEdge = wireDiameter + 1;
plateHeight = flat ? plateEdge : max(flangeHeight, plateEdge, gouged ? plateEdge * 5 / 3 : 0);

/**
 * Renders a hole to grip a wire.
 * @param Number wireDiameter
 * @param Number aperturePercent
 */
module wireHole(wireDiameter, aperturePercent) {
    wireRadius = wireDiameter / 2;
    apertureWidth = wireDiameter * max(0, min(aperturePercent, 100)) / 100;
    apertureDistance = pythagoras(b=apertureWidth / 2, c=wireRadius);
    apertureHeight = wireRadius - apertureDistance;
    aperturePos = apertureDistance + apertureHeight / 2;

    translateY(wireRadius - ALIGN) {
        circle(d=wireDiameter);
        translateY(-aperturePos + apertureDistance / 2) {
            square([apertureWidth, apertureHeight + apertureDistance], center=true);
        }
    }
}

// Sets the minimum facet angle and size using the defined render mode.
applyMode(renderMode) {
    //sample([wireDiameter + padding * 2, plateWidth, plateHeight]) translateX(-wireInterval / 2)
    rotateZ(90) {
        rotateX(90) {
            difference() {
                translateX(-plateWidth / 2) {
                    linear_extrude(height=plateLength, center=true, convexity=10) {
                        polygon(
                            points=path(concat([
                                    ["H", plateWidth],
                                    ["V", plateEdge]
                                ], gouged && !flat
                               ?[
                                    ["L", -plateWidth / 2, plateEdge / 3],
                                    ["L", -plateWidth / 8, plateEdge / 3]
                                ]
                               :[], [
                                    ["P", plateEdge / 2, plateHeight],
                                    ["P", 0, plateHeight]
                                ])),
                                convexity=10
                            );
                        }
                }
                translateZ(wireInterval / 2) {
                    repeat(count=2, intervalZ=-wireInterval) {
                        rotateY(90) {
                            linear_extrude(height=plateWidth + ALIGN2, center=true, convexity=10) {
                                wireHole(wireDiameter, aperturePercent);
                            }
                        }
                    }
                }
            }
        }
    }
}
