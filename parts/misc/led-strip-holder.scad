/**
 * @license
 * GPLv3 License
 *
 * Copyright (c) 2019-2022 Jean-Sebastien CONAN
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
 */

// Import the project's setup.
include <../../config/setup.scad>

// Defines the constraints of the object.
ledStripWidth = 8.5;
ledStripThickness = .5;
screwDiameter = 3;
thickness = 1;
ledStripPadding = 1;
screwPadding = 1.5;

// Defines the dimensions of the object.
groove = ceilBy(ledStripThickness, layerHeight);
length = ledStripWidth + screwDiameter + 2 * screwPadding + ledStripPadding;
width = screwDiameter + 2 * screwPadding;
height = ceilBy(thickness - ledStripThickness, layerHeight) + groove;

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
