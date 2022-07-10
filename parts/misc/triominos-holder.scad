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
 * A parametric holder for triominos.
 *
 * @author jsconan
 */

// Import the project's setup.
include <../../config/setup.scad>

// Defines the constraints of the object.
// - size of a piece
pieceWidth = 38;
pieceHeight = 28;
pieceThickness = 9;
// - size of a board
pieceInterval = 1;
piecesByBoard = 5;
boardThickness = 2;
// size of the groove in which the board will be plugged
grooveWall = shells(3);
grooveDepth = 2;
// - constraints of the holder
boardCount = 2;
boardAngle = 55;

// Defines the dimensions of the object.
boardInterval = pieceHeight * 1.3;

/**
 * The edge of a board that will support a range of pieces
 * @param Number width
 * @param Number height
 * @param Number thickness
 * @param Number count
 */
module standBoardEdge(width, height, thickness, count, distance=0) {
    polygon(
        points=outline(points=path(
            p=[
                ["P", 0, 0],
                ["H", thickness],
                ["R", count, [
                    ["H", width + thickness],
                    ["V", height]
                ]],
                ["V", thickness],
                ["H", -thickness],
                ["R", count, [
                    ["V", -height],
                    ["H", -width - thickness]
                ]]
            ]
        ), distance=distance),
        convexity=10
    );
}

/**
 * The side of a board that will support a range of pieces
 * @param Number width
 * @param Number height
 * @param Number thickness
 * @param Number wall
 * @param Number depth
 * @param Number angle
 * @param Number count
 */
module standBoardSide(width, height, thickness, wall, depth, angle, count) {
    rotateAngle = -(90 - angle);

    margin = thickness + wall * 2;
    outerWidth = (width + thickness) * count + margin;
    outerHeight = height * count + margin;
    outerThickness = thickness + depth;

    pivot = width + thickness + margin;
    axle = [outerWidth, outerHeight] - vector2D(margin / 2);
    leg = rotp(axle - [pivot, 0], rotateAngle);

    translateX(pivot * cos(rotateAngle)) {
        rotateZ(rotateAngle) {
            translate([wall - pivot, wall, 0]) {
                difference() {
                    // outline
                    negativeExtrude(height=outerThickness) {
                        // side
                        standBoardEdge(width, height, thickness, count, distance=wall);

                        // leg
                        translate(axle - [wall, wall]) {
                            rotateZ(-rotateAngle) {
                                translateY((outerThickness / 2 - leg[1]) / 2) {
                                    stadium(size=[outerThickness, leg[1] + outerThickness / 2], d=outerThickness);
                                }
                            }
                        }
                    }

                    // groove
                    translateZ(thickness) {
                        negativeExtrude(height=outerThickness) {
                            standBoardEdge(width, height, thickness, count);
                        }
                    }
                }
            }
        }
    }
}

/**
 * A board that will support a range of pieces
 * @param Vector pieceSize
 * @param Number count
 * @param Number thickness
 * @param Number padding
 */
module standBoard(pieceSize, count, thickness, padding) {
    pieceSize = vector3D(pieceSize);
    half = thickness / 2;
    depth = layerAligned(half);

    grooveDepth = depth + layerHeight;
    grooveWidth = half;

    ridgeHeight = depth - layerHeight;
    ridgeWidth = half;

    outerLength = pieceSize[0] * count + padding * 2;
    outerWidth = pieceSize[1] + thickness;
    outerHeight = pieceSize[2] + thickness + ridgeHeight;

    difference() {
        // board
        box([outerLength, outerWidth, outerHeight]);
        translate([0, thickness, thickness]) {
            box([outerLength + ALIGN2, outerWidth, outerHeight]);
        }

        // ridge
        translate([0, thickness - (outerWidth + ridgeWidth) / 2, outerHeight - ridgeHeight]) {
            box(vadd([outerLength, ridgeWidth, ridgeHeight], ALIGN2));
        }

        // groove
        translate([0, (outerWidth + grooveWidth) / 2 - thickness, -ALIGN]) {
            box(vadd([outerLength, grooveWidth, grooveDepth], ALIGN2));
        }
    }
}

// Sets the minimum facet angle and size using the defined render mode.
applyMode(mode=renderMode) {
    // Uncomment the next line to cut a sample from the object
    //sample(size=[DEFAULT_BUILD_PLATE_SIZE, DEFAULT_BUILD_PLATE_SIZE, 5], offset=[0, 0, 0])

    // sides
    translateY(((boardCount - 1) * boardInterval) / 2) {
        repeatMirror(count=2) {
            translateX(pieceThickness) {
                standBoardSide(
                    width = pieceThickness,
                    height = pieceHeight,
                    thickness = boardThickness,
                    wall = grooveWall,
                    depth = grooveDepth,
                    angle = boardAngle,
                    count = boardCount
                );
            }
        }
    }

    // boards
    translateY(-(boardCount * boardInterval) / 2) {
        repeat(count=boardCount, interval=[0, boardInterval, 0]) {
            standBoard(
                pieceSize = [
                    pieceWidth + pieceInterval,
                    pieceHeight,
                    pieceThickness
                ],
                count = piecesByBoard,
                thickness = boardThickness,
                padding = grooveDepth
            );
        }
    }

}
