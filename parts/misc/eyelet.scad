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
 * A parametric eyelet tube.
 *
 * @author jsconan
 */

// Import the project's setup.
include <../../config/setup.scad>

// Defines the dimensions of the object
thickness = 1;
rimDiameter = 40;
holeDiameter = 30;
tubeDiameter = holeDiameter + 2 * thickness;
tubeDepth = 5;

// Sets the minimum facet angle and size using the defined render mode.
applyMode(mode=renderMode) {
    difference() {
        union() {
            pipe(d=tubeDiameter, w=thickness, h=tubeDepth + thickness);
            cylinder(d=rimDiameter, h=thickness);
        }
        translateZ(-ALIGN) {
            cylinder(d1=tubeDiameter, d2=holeDiameter, h=thickness + ALIGN2);
        }
    }
}
