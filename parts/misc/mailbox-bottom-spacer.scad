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
 * A spacer for the bottom of a mailbox to prevent direct contact with the ground.
 *
 * @author jsconan
 */

// Import the project's setup.
include <../../config/setup.scad>

// Defines the constraints of the object.
length = 89;
width = 84;
height = 7;
fillet = 4;
thickness = 2;
meshWidth = 10;
meshGap = 2;
meshPointy = true;
legWidth = 8;

// The mailbox bottom spacer object.
module mailboxBottomSpacer(length=length, width=width, height=height, fillet=fillet, thickness=thickness, meshWidth=meshWidth, meshGap=meshGap, meshPointy=meshPointy, legWidth=legWidth) {
    innerHollowedLength = length - 2 * thickness;
    innerHollowedWidth = width - 2 * thickness;
    outerHollowedLength = length - 2 * legWidth;
    outerHollowedWidth = width - 2 * legWidth;
    meshHollowedLength = innerHollowedLength - meshGap;
    meshHollowedWidth = innerHollowedWidth - meshGap;
    hollowedHeight = height - thickness;
    meshCells = countHexCell(size=[innerHollowedLength, innerHollowedWidth, height], cell=[meshWidth, meshWidth], pointy=meshPointy, linear=true);

    difference(){
        cushion(size=[length, width, height], r=fillet);
        translateZ(-1) {
            cushion(size=[innerHollowedLength, innerHollowedWidth, hollowedHeight + 1], r=fillet - thickness);
        }
        rotateX(90) {
            cushion(size=[outerHollowedLength, hollowedHeight * 2, width + 1], r=hollowedHeight, center=true);
        }
        rotateY(90) {
            cushion(size=[hollowedHeight * 2, outerHollowedWidth, length + 1], r=hollowedHeight, center=true);
        }
        translateZ(thickness) {
            intersection() {
                cushion(size=[meshHollowedLength, meshHollowedWidth, height], r=fillet - thickness - meshGap / 2);
                meshBox(size=[meshHollowedLength, meshHollowedWidth, height], count=meshCells, pointy=meshPointy, linear=true, full=true, gap=meshGap);
            }
        }
    }
}

// Sets the minimum facet angle and size using the defined render mode.
// Displays a build box visualization to preview the printer area.
applyMode(mode=renderMode) {
    // Uncomment the next line to cut a sample from the object
    //sample(size=[DEFAULT_BUILD_PLATE_SIZE, DEFAULT_BUILD_PLATE_SIZE, 5], offset=[0, 0, 0])
    rotateY(180) {
        translateZ(-height) {
            mailboxBottomSpacer();
        }
    }
}
