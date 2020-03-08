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
 * A small bracket that will hold a LED strip.
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
printResolution = 0.2;

// Defines the constraints of the object.
ledStripWidth = 8.5;
ledStripThickness = .5;
screwDiameter = 3;
thickness = 1;
ledStripPadding = 1;
screwPadding = 1.5;

// Defines the dimensions of the object.
groove = ceilBy(ledStripThickness, printResolution);
length = ledStripWidth + screwDiameter + 2 * screwPadding + ledStripPadding;
width = screwDiameter + 2 * screwPadding;
height = ceilBy(thickness - ledStripThickness, printResolution) + groove;

// Displays a build box visualization to preview the printer area.
buildBox(center=true);

// Sets the minimum facet angle and size using the defined render mode.
applyMode(mode=renderMode) {
    difference() {
        // main shape
        union() {
            translateX(width / 4) {
                box(size=[length - width / 2, width, height]);
            }
            translateX(-(length - width) / 2) {
                cylinder(d=width, h=height);
            }
        }
        // make room for the LED strip
        translate([(length - ledStripWidth) / 2 - ledStripPadding, 0, height - groove]) {
            box(size=[ledStripWidth, width + ALIGN2, groove + ALIGN]);
        }
        // drill the hole for the screw
        translate([screwPadding - (length - screwDiameter) / 2, 0, -ALIGN]) {
            cylinder(d=screwDiameter, h=height + ALIGN2);
        }
    }
}
