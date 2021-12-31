/**
 * @license
 * GPLv3 License
 *
 * Copyright (c) 2021 Jean-Sebastien CONAN
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
 * A label holder.
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

// Defines the constraints of the object.
holeDiameter = 6;
holePadding = 2;
labelWidth = 37;
labelLength = 70;
labelThickness = .8;
labelPocketThickness = .2;
labelPocketMargin = .8;
labelPocketPadding = .5;

// Defines the dimensions of the object.
padding = labelPocketMargin + labelPocketPadding;
width = labelWidth + 2 * padding;
length = labelLength + 2 * padding;
roundRadius = holeDiameter / 2 + holePadding;
roundDiff = pythagoras(a=roundRadius, b=roundRadius) - roundRadius;
arrowWidth = width * cos(45);
arrowInnerWidth = arrowWidth + roundRadius - roundDiff;
arrowHeight = pythagoras(a=arrowWidth, b=arrowWidth) / 2;
pocketLength = labelLength + labelPocketPadding * 2;
pocketWidth = labelWidth + labelPocketPadding * 2;

// Sets the minimum facet angle and size using the defined render mode.
applyMode(mode=renderMode) {
    difference() {
        linear_extrude(height=labelThickness) {
            rotateZ(45) {
                roundedRectangle(size=arrowInnerWidth, r=roundRadius);
            }
            translateX(length / 2) {
                rectangle([length, width]);
            }
        }
        translateX(roundRadius - arrowHeight) {
            cylinder(d=holeDiameter, h=labelThickness * 3, center=true);
        }
        translate([length / 2, 0, labelThickness - labelPocketThickness]) {
            box([pocketLength, pocketWidth, labelThickness]);
        }
    }
}
