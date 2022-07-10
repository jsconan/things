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
 * A feet set to put under a cylindric food dehydratator.
 *
 * @author jsconan
 */

// Import the project's setup.
include <../../config/setup.scad>

// Defines the constraints of the object.
dehydratatorFootWidth = 14;
dehydratatorFootThickness = 3;
dehydratatorFootHeight = 8;
topWidthDiff = .2;
topThicknessDiff = .2;
wallThickness = 2;
count = 4;

// Defines the dimensions of the object.
additionalThickness = wallThickness * 2;
footWidth = dehydratatorFootWidth + additionalThickness;
footThickness = dehydratatorFootThickness + additionalThickness;
footHeight = layerAligned(dehydratatorFootHeight + wallThickness);
intervalX = footThickness + wallThickness;

/**
 * @param Vector bottom
 * @param Vector top
 * @param Number height
 */
module foot(bottom, top, height) {
    hull() {
        slot(size=bottom, h=ALIGN, d=bottom[0]);
        translateZ(height - ALIGN) {
            slot(size=top, h=ALIGN, d=top[0]);
        }
    }
}

// Sets the minimum facet angle and size using the defined render mode.
applyMode(mode=renderMode) {
    translateX(-((count - 1) * intervalX) / 2) {
        repeat(
            count=count,
            interval=[intervalX, 0, 0]
        ) {
            difference() {
                foot(
                    bottom=[footThickness, footWidth],
                    top=[footThickness + topThicknessDiff, footWidth + topWidthDiff],
                    height=footHeight
                );
                translateZ(footHeight - dehydratatorFootHeight) {
                    foot(
                        bottom=[dehydratatorFootThickness, dehydratatorFootWidth],
                        top=[dehydratatorFootThickness + topThicknessDiff, dehydratatorFootWidth + topWidthDiff],
                        height=dehydratatorFootHeight + ALIGN
                    );
                }
            }
        }
    }
}
