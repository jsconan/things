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
 * A stopper for knitting needles.
 *
 * @author jsconan
 */

// Import the project's setup.
include <../../config/setup.scad>

// Defines the constraints of the object.
needle_diameter = 4.9;          // The diameter of the needle.
stopper_thickness = 5.0;        // The thickness of the stopper.

// Computes the other dimensions of the stopper based on the needle diameter and the defined constraints.
stopper_diameter = needle_diameter * 4;
stopper_fillet_radius = needle_diameter / 3;
stopper_joint_width = needle_diameter / 6;
stopper_joint_padding = needle_diameter / 1.5;

needle_radius = needle_diameter / 2;
stopper_radius = stopper_diameter / 2;
top_joint_radius = stopper_radius - needle_radius - stopper_fillet_radius;
bottom_joint_radius = top_joint_radius - stopper_joint_width / 2 - stopper_joint_padding;

stopper_joint_angle = getChordAngle(length=stopper_joint_width / 2 + stopper_fillet_radius, radius=stopper_radius);
needle_hole_joint_angle = getChordAngle(length=stopper_joint_width / 2, radius=needle_radius);

// Sets the minimum facet angle and size using the defined render mode.
// Displays a build box visualization to preview the printer area.
applyMode(mode=renderMode) {
    // Uncomment the next line to cut a sample from the object
    //sample(size=[DEFAULT_BUILD_PLATE_SIZE, DEFAULT_BUILD_PLATE_SIZE, 5], offset=[0, 0, 0])
    linear_extrude(height=stopper_thickness, convexity=10) {
        polygon(points=path([
            ["P", arcp(r=needle_radius, a=90 + needle_hole_joint_angle)],               // start position at the top of the needle hole
            ["C", needle_radius, 90 + needle_hole_joint_angle, 270],                    // needle hole first half-circle
            ["C", needle_radius, -90, 90 - needle_hole_joint_angle],                    // needle hole second half-circle
            ["V", top_joint_radius],                                                    // top joint straight line
            ["C", stopper_fillet_radius, 180, 90],                                      // fillet between the top joint and the outer edge of the stopper
            ["C", stopper_radius, 90 - stopper_joint_angle, stopper_joint_angle - 90],  // stopper outer edge first half-circle
            ["C", stopper_fillet_radius, 270, 180],                                     // fillet between the top joint and the outer edge of the stopper
            ["V", bottom_joint_radius],                                                 // bottom joint straight line
            ["C", stopper_joint_width / 2, 0, 180],                                     // fillet between the bottom joint and the outer edge of the stopper
            ["V", -bottom_joint_radius],                                                // bottom joint straight line
            ["C", stopper_fillet_radius, 0, -90],                                       // fillet between the bottom joint and the outer edge of the stopper
            ["C", stopper_radius, 270 - stopper_joint_angle, 90 + stopper_joint_angle], // stopper outer edge second half-circle
            ["C", stopper_fillet_radius, 90, 0],                                        // fillet between the top joint and the outer edge of the stopper
        ]));
    }
}
