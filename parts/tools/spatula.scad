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
 * A simple spatula.
 *
 * @author jsconan
 */

// Import the project's setup.
include <../../config/setup.scad>

// Defines the constraints of the object.
thickness = 1;
bladeWidth = 6;
bladeLength = 10;
bladeRound = 3;
handleLength = 100;
handleWidth = 3;

// Defines the dimensions of the object.
bladeThickness = layerAligned(thickness);
bladeSize = [bladeLength, bladeWidth, bladeThickness];
handleSize = [handleLength, handleWidth, bladeThickness];
handleRound = handleWidth;

// Sets the minimum facet angle and size using the defined render mode.
applyMode(mode=renderMode) {
    cushion(size=bladeSize, r=bladeRound);
    translateX(handleLength / 2) {
        cushion(size=handleSize, r=handleRound);
        translateZ(bladeThickness) {
            rotateY(90) {
                pill(size=reverse(handleSize) + [bladeThickness, 0, 0], r=handleRound);
            }
        }
    }
}
