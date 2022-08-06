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
 * A simple knob for SMA connectors.
 *
 * @author jsconan
 */

// Import the project's setup.
include <../../../config/setup.scad>

// Defines the dimensions of the object
knobSize = 8;
knobThickness = 3;

/**
 * Renders a hex knob with respect to the given size of the hex nut.
 * @param Number hex - The size of the hex nut across opposite flats.
 * @param Number thickness - The thickness of the knob.
 */
module hexKnob(hex, thickness) {
    hexSide = hex / (2 * cos(30));
    edgeRadius = hexSide;
    sideRadius = hexSide;
    offsetX = -edgeRadius;
    offsetY = -(edgeRadius + sideRadius) / (2 * cos(30));

    negativeExtrude(height=thickness) {
        difference() {
            polygon(points=path([
                ["P", offsetX, offsetY],
                ["C", edgeRadius, 180, 360],
                ["C", sideRadius, 180, 120],
                ["C", edgeRadius, -60, 120],
                ["C", sideRadius, -60, -120],
                ["C", edgeRadius, 60, 240],
                ["C", sideRadius, 60, 0],
            ]), convexity=10);
            hexagon(s=hexSide);
        }
    }
}

// Sets the minimum facet angle and size using the defined render mode.
applyMode(mode=renderMode) {
    hexKnob(hex=knobSize, thickness=knobThickness);
}
