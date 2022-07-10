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
 * A spool holder that mounts on a cylindric food dehydratator.
 *
 * @author jsconan
 */

// Import the project's setup.
include <../../config/setup.scad>

// Defines the constraints of the object.
mountDiameter = 79;
mountDepth = 5;
mountWall = 5;

plateThickness = 5;
plateRidgeWidth = 1;
plateRidgeHeight = .5;
plateRidgeCount = 4;

spoolHoleDiameter = 50;
spoolHoleHeight = 30;
spoolHoleChamfer = 1;
spoolHoleRidgeWidth = 1;
spoolHoleRidgeHeight = .5;
spoolHoleRidgeCount = 6;

// Defines the dimensions of the object.
plateHeight = layerAligned(plateThickness + mountDepth - plateRidgeHeight);
plateDiameter = mountDiameter + mountWall * 2;
plateBrim = (plateDiameter - spoolHoleDiameter) / 2;
plateRidgeInterval = plateBrim / plateRidgeCount - plateRidgeWidth;
plateRidgeX = plateRidgeWidth / 2 * cos(60);
plateRidgeY = plateRidgeHeight;

spoolHoleInnerDiameter = spoolHoleDiameter - spoolHoleRidgeHeight * 2;
spoolHoleRidgeInterval = (spoolHoleHeight - spoolHoleRidgeWidth) / spoolHoleRidgeCount - spoolHoleRidgeWidth;
spoolHoleRidgeX = spoolHoleRidgeHeight;
spoolHoleRidgeY = spoolHoleRidgeWidth / 2 * cos(60);

// Sets the minimum facet angle and size using the defined render mode.
applyMode(mode=renderMode) {
    //sample(size=vadd([plateDiameter, plateDiameter, 8], ALIGN2), offset=[0, 0, -ALIGN])
    //sample(size=vadd([plateDiameter, plateDiameter, 8], ALIGN2), offset=[0, 0, plateHeight+spoolHoleHeight-8-ALIGN])
    rotate_extrude() {
        polygon(
            points=path(concat([
                // mount side
                ["P", 0, mountDepth],
                ["H", mountDiameter / 2],
                ["V", -mountDepth],
                ["H", mountWall],

                // plate side
                ["V", plateHeight],
                ["R", plateRidgeCount, [
                    ["L", -plateRidgeX, plateRidgeY],
                    ["H", -plateRidgeWidth + plateRidgeX * 2],
                    ["L", -plateRidgeX, -plateRidgeY],
                    ["L", -plateRidgeInterval, 0]
                ]],

                // spool hole side
                ["P", spoolHoleInnerDiameter / 2, plateHeight],
                ["R", spoolHoleRidgeCount, [
                    ["L", 0, spoolHoleRidgeInterval],
                    ["L", spoolHoleRidgeX, spoolHoleRidgeY],
                    ["V", spoolHoleRidgeWidth - spoolHoleRidgeY * 2],
                    ["L", -spoolHoleRidgeX, spoolHoleRidgeY],
                ]],
                ["L", -spoolHoleChamfer, spoolHoleChamfer],
                ["H", -spoolHoleInnerDiameter / 2 + spoolHoleChamfer],
            ])),
            convexity=10
        );
    }
}
