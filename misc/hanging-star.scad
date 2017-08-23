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
 * A parametric hanging star.
 *
 * @author jsconan
 */

// As we need to use some shapes, use the right entry point of the library
use <../lib/camelSCAD/shapes.scad>
include <../lib/camelSCAD/core/constants.scad>

// We will render the object using the specifications of this mode
renderMode = MODE_PROD;

// Defines the dimensions of the star
radius = 40;
thickness = 3;
holeDiameter = 4;
ringThickness = 2;
ringDiameter = holeDiameter + ringThickness * 2;
coreRadius = (radius * 2) * (1 - 3 / 5);

// Sets the minimum facet angle and size using the defined render mode.
applyMode(renderMode) {
    // This is the frame of the star
    difference() {
        starBox(size=radius, h=thickness, edges=5, center=true);
        starBox(size=radius / 1.5, h=thickness + 1, edges=5, center=true);
    }
    // This is the core of the star
    rotateZ(180) {
        difference() {
            regularPolygonBox(size=coreRadius, n=5, h=thickness, center=true);
            cylinder(r=radius / 5, h=thickness + 1, center=true);
        }
    }
    // This is the ring to hook the star
    translate([0, radius + ringThickness]) {
        pipe(d=ringDiameter, w=ringThickness, h=thickness, center=true);
    }
}
