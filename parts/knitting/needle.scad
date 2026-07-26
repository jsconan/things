/**
 * @license
 * GPLv3 License
 *
 * Copyright (c) 2026 Jean-Sebastien CONAN
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
 * A headed needle.
 *
 * @author jsconan
 */

// Import the project's setup.
include <../../config/setup.scad>

// Defines the constraints of the object.
needle_diameter = 5.0;          // The diameter of the needle.
needle_length = 50.0;           // The length of the needle.
needle_tip_length = 10.0;       // The length of the tip of the needle.
needle_base_diameter = 10.0;    // The diameter of the base of the stopper.
needle_base_height = 30.0;      // The height of the base of the stopper


// Sets the minimum facet angle and size using the defined render mode.
// Displays a build box visualization to preview the printer area.
applyMode(mode=renderMode) {
    // Uncomment the next line to cut a sample from the object
    //sample(size=[DEFAULT_BUILD_PLATE_SIZE, DEFAULT_BUILD_PLATE_SIZE, 5], offset=[0, 0, 0])
    cylinder(d=needle_base_diameter, h=needle_base_height);
    translate([0, 0, needle_base_height]) {
        cylinder(d=needle_diameter, h=needle_length);
        translate([0, 0, needle_length]) {
            cylinder(d1=needle_diameter, d2=needle_diameter / 2, h=needle_tip_length);
        }
    }
}
