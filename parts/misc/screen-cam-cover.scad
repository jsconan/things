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
 * A parametric cover for built-in screen camera.
 *
 * @author jsconan
 */

// Import the project's setup.
include <../../config/setup.scad>

// Defines the dimensions of the object
screenThickness = 20;
screenBorder = 13;
coverWidth = 50;
coverThickness = 1;
coverClip = 5;
coverPadding = .8;
coverHoleRadius = 5;

// Compute the derived dimensions of the object
coverRoundCorner = coverThickness / 2;
clipInner = coverClip - coverRoundCorner;
clipOuter = clipInner + coverThickness - coverRoundCorner;
coverTop = screenThickness + coverThickness * 2 - coverRoundCorner * 2;
coverInner = screenBorder - coverRoundCorner;
coverOuter = coverInner + coverThickness - coverRoundCorner;

coverMeshWidth = coverWidth - coverPadding * 2;
coverMeshLength = screenThickness - coverPadding * 2;
coverMeshCount = [coverMeshLength / coverHoleRadius, coverMeshWidth / coverHoleRadius];
echo(coverMeshCount);
coverMeshGap = coverPadding;
cutThickness = coverThickness + 0.2;

// Sets the minimum facet angle and size using the defined render mode.
applyMode(mode=renderMode) {
    // Uncomment the next line to cut a sample from the object
    // sample([standWidth + 1, 30, 20], offset=[0, standWidth/2 + 30, 0], center=true)
    difference() {
        rotateX(-90) {
            translate([-screenThickness / 2, -coverThickness, -coverWidth / 2]) {
                linear_extrude(height=coverWidth, convexity=10) {
                    polygon(points=path(
                        [
                            ["P", 0, 0],
                            ["H", screenThickness],
                            ["V", -clipInner],
                            ["C", coverRoundCorner, 180, 360],
                            ["V", clipOuter],
                            ["C", coverRoundCorner, 0, 90],
                            ["H", -coverTop],
                            ["C", coverRoundCorner, 90, 180],
                            ["V", -coverOuter],
                            ["C", coverRoundCorner, 180, 360],
                            ["V", coverOuter],
                        ]
                    ));
                }
            }
        }

        translateZ(-0.1) {
            intersection() {
                cushion([coverMeshLength, coverMeshWidth, cutThickness], r=coverRoundCorner);
                meshBox([coverMeshLength, coverMeshWidth, cutThickness], count=coverMeshCount, gap=coverMeshGap, linear=true, full=true);
            }
        }
    }
}
