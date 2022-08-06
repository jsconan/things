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
 * A hook that fits onto a cabinet door.
 *
 * @author jsconan
 */

// Import the project's setup.
include <../../config/setup.scad>

// Defines the constraints of the object.
doorThickness = 16;
thickness = 3;
width = 15;
length = 60;
flange = 10;
hookDepth = 12;
hookHeight = 10;
roundRadius = 5;

// Defines the dimensions of the object.
radius = thickness / 2;
flangeInnerHeight = flange - radius;
flangeOuterHeight = flangeInnerHeight + thickness - radius;
doorInnerThickness = doorThickness;
doorOuterThickness = doorInnerThickness + (thickness - radius) * 2;
hookInnerHeight = hookHeight - radius;
hookInnerRadius = hookDepth / 2;
hookOuterRadius = hookInnerRadius + thickness;
innerLength = length - hookOuterRadius - thickness;
outerLength = innerLength + thickness - radius;

// Sets the minimum facet angle and size using the defined render mode.
applyMode(mode=renderMode) {
    // sample([100, 100, 3])
    difference() {
        linear_extrude(height=width) {
            polygon(path([
                ["P", 0, -radius],
                ["C", radius, 180, 0],
                ["V", -hookInnerHeight],
                ["C", hookOuterRadius, 360, 180],
                ["V", innerLength],
                ["H", -doorInnerThickness],
                ["V", -flangeInnerHeight],
                ["C", radius, 360, 180],
                ["V", flangeOuterHeight],
                ["C", radius, 180, 90],
                ["H", doorOuterThickness],
                ["C", radius, 90, 0],
                ["V", -outerLength],
                ["C", hookInnerRadius, 180, 360],
            ]), convexity = 10);
        }

        translate([thickness, 0, width] / 2) {
            rotateY(90) {
                translateX(-width / 2) {
                    roundedCornerWedge(r=roundRadius, h=thickness*2, p=[1,-1], adjust=1, center=true);
                    translateX(width) {
                        roundedCornerWedge(r=roundRadius, h=thickness*2, p=[-1,-1], adjust=1, center=true);
                    }
                }
            }
        }
    }
}
