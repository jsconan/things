/**
 * @license
 * GPLv3 License
 *
 * Copyright (c) 2018 Jean-Sebastien CONAN
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
 * A simple parametric storage rack.
 *
 * @author jsconan
 * @version 0.1.0
 */

// As we need to use some shapes, use the right entry point of the library
use <../lib/camelSCAD/shapes.scad>
include <../lib/camelSCAD/core/constants.scad>

// We will render the object using the specifications of this mode
renderMode = MODE_PROD;

// Defines the constraints of the object
fixingHoleCount = 3;
hookCount = 6;

// Defines the dimensions of the object
plateLength = 200;
plateWidth = 40;
plateThickness = 3;
chamferWidth = 5;

fixingHoleDiameter = 6.5;
fixingHoleChamfer = 1;
fixingHoleChamferDepth = .8;

hookLength = 11;
hookWidth = 10;
hookHeight = 30;
hookTipRatio = [.3, .2];
hookChamfer = 1;

// Computes the constrained dimensions of the object
fixingHoleInterval = plateLength / divisor(fixingHoleCount);
fixingHoleStart = (plateLength - fixingHoleInterval) / 2;

hookInterval = plateLength / divisor(hookCount);
hookStart = (plateLength - hookInterval) / 2;

// Sets the minimum facet angle and size using the defined render mode.
applyMode(renderMode) {

    difference() {
        chamferedBox(size=[plateLength, plateWidth, plateThickness], chamfer=chamferWidth);

        if (fixingHoleCount > 0) {
            translateX(-fixingHoleStart) {
                repeat(count=fixingHoleCount, intervalX=fixingHoleInterval) {
                    negativeExtrude(height=plateThickness, convexity=10) {
                        circle(d=fixingHoleDiameter);
                    }

                    translateZ(plateThickness - fixingHoleChamferDepth + ALIGN) {
                        cylinder(h=fixingHoleChamferDepth + ALIGN2, d1=fixingHoleDiameter, d2=fixingHoleDiameter + fixingHoleChamfer * 2);
                    }
                }
            }
        }
    }

    translate([-hookStart, -hookWidth, plateThickness - ALIGN]) {
        repeat(count=hookCount, intervalX=hookInterval) {
            linear_extrude(height=hookHeight, convexity=10, scale=hookTipRatio, twist=0)
                translateY(hookWidth)
                    chamferedRectangle([hookLength, hookWidth], hookChamfer);
        }
    }
}
