/**
 * @license
 * GPLv3 License
 *
 * Copyright (c) 2022 Jean-Sebastien CONAN
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
 * Global functions.
 *
 * @author jsconan
 */

/**
 * Aligns a value with respect to the target layer height.
 * @param Number value
 * @returns Number
 */
function layerAligned(value) = roundBy(value, layerHeight);

/**
 * Aligns a value with respect to the target nozzle size.
 * @param Number value
 * @returns Number
 */
function nozzleAligned(value) = roundBy(value, nozzleWidth);

/**
 * Gets the thickness of N layers.
 * @param Number N
 * @returns Number
 */
function layers(N) = N * layerHeight;

/**
 * Gets the width of N times the nozzle width.
 * @param Number N
 * @returns Number
 */
function shells(N) = N * nozzleWidth;

/**
 * Computes the print interval between the centers of 2 objects.
 * @param Number size - The size of the shape.
 * @returns Number
 */
function getPrintInterval(size) = size + printInterval;

/**
 * Gets the adjusted quantity of shapes to place on a grid with respect to the size of one shape.
 * @param Number length - The length of the shape.
 * @param Number width - The width of the shape.
 * @param Number [quantity] - The number of shapes to place.
 * @returns Number
 */
function getMaxQuantity(length, width, quantity=1) =
    let(
        maxLine = floor(printerLength / length),
        maxCol = floor(printerWidth / width)
    )
    min(maxLine * maxCol, quantity)
;

/**
 * Gets the maximal number of shapes that can be placed on a line with respect the size of one shape.
 * @param Number length - The length of the shape.
 * @param Number width - The width of the shape.
 * @param Number [quantity] - The number of shapes to place.
 * @param Number [line] - The expected number of shapes per line.
 * @returns Number
 */
function getMaxLine(length, width, quantity=1, line=undef) =
    let(
        maxLine = floor(printerLength / length)
    )
    min(uor(line, ceil(sqrt(quantity))), maxLine)
;

/**
 * Gets the overall length of the area taken to place the repeated shapes on a grid with respect to the expected quantity.
 * @param Number length - The length of the shape.
 * @param Number width - The width of the shape.
 * @param Number [quantity] - The number of shapes to place.
 * @param Number [line] - The expected number of shapes per line.
 * @returns Number
 */
function getGridLength(length, width, quantity=1, line=undef) =
    let(
        length = getPrintInterval(length),
        width = getPrintInterval(width),
        quantity = getMaxQuantity(length, width, quantity)
    )
    min(quantity, getMaxLine(length, width, quantity, line)) * length
;

/**
 * Gets the overall width of the area taken to place the repeated shapes on a grid with respect to the expected quantity.
 * @param Number length - The length of the shape.
 * @param Number width - The width of the shape.
 * @param Number [quantity] - The number of shapes to place.
 * @param Number [line] - The expected number of shapes per line.
 * @returns Number
 */
function getGridWidth(length, width, quantity=1, line=undef) =
    let(
        length = getPrintInterval(length),
        width = getPrintInterval(width),
        quantity = getMaxQuantity(length, width, quantity),
        line = getMaxLine(length, width, quantity, line)
    )
    ceil(quantity / line) * width
;

/**
 * Prints the project version, including the package version.
 * @returns String
 */
function printVersion() = str(PROJECT_VERSION);
