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
 * A parametric stand base for the hand shape.
 *
 * @author jsconan
 */

// Import the project's setup.
include <../../config/setup.scad>

// Defines the dimensions of the object
handThickness = 3;
handScale = 1.0;

slotAngle = 70;
slotLength = 66 * handScale;
slotWidth = handThickness + 0.2;
slotPadding = 10 * handScale;

standWidth = 100 * handScale;
standLength = slotLength + slotPadding * 2;
standThickness = 5 * handScale;
standRadius = 10 * handScale;

slotBumperThickness = 5 * handScale;
slotBumperWidth = slotWidth + slotPadding;
slotBumperLength = slotLength + slotPadding;
slotBumperRadius = standRadius - slotPadding / 2;
slotBumperPadding = slotPadding * (1 + cos(slotAngle));
slotBumperOffset = standWidth / 2 - slotBumperPadding;

standWallThickness = 5 * handScale;
standGroundThickness = 2 * handScale;
standHollowWidth = standWidth - standWallThickness * 2 - slotBumperWidth / 2 - slotBumperPadding;
standHollowLength = standLength - standWallThickness * 2;
standHollowRadius = standRadius - standWallThickness;
standHollowOffset = standWallThickness - (standWidth - standHollowWidth) / 2 ;

standMeshGap = 2 * handScale;
standMeshPadding = 2 * handScale;
standMeshWidth = standHollowWidth - standMeshPadding * 2;
standMeshLength = standHollowLength - standMeshPadding * 2;
standMeshRadius = standRadius - standMeshPadding - standWallThickness;
standMeshOffset = standMeshPadding + standWallThickness - (standWidth - standMeshWidth) / 2 ;

cutThickness = standThickness + slotBumperThickness + 2;

// Sets the minimum facet angle and size using the defined render mode.
applyMode(mode=renderMode) {
    // Uncomment the next line to cut a sample from the object
    // sample([standWidth + 1, 30, 20], offset=[0, standWidth/2 + 30, 0], center=true)
    difference() {
        hull(){
            cushion([standLength, standWidth, standThickness], r=standRadius);
            translate([0, slotBumperOffset, standThickness]) {
                cushion([slotBumperLength, slotBumperWidth, slotBumperThickness], r=slotBumperRadius);
            }
        }
        translate([0, standMeshOffset, -1]) {
            intersection() {
                cushion([standMeshLength, standMeshWidth, cutThickness], r=standMeshRadius);
                meshBox([standMeshLength, standMeshWidth, cutThickness], count=8, gap=standMeshGap, linear=true, full=false);
            }
        }
        translate([0, standHollowOffset, standGroundThickness]) {
            cushion([standHollowLength, standHollowWidth, cutThickness], r=standHollowRadius);
        }
        translateY(standWidth / 2 - slotPadding) {
            rotateX(90 - slotAngle) {
                translateZ((1 - cos(slotAngle))) {
                    box([slotLength, slotWidth, cutThickness * 2]);
                }
            }
        }
    }
}
