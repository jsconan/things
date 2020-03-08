/**
 * @license
 * GPLv3 License
 *
 * Copyright (c) 2019-2020 Jean-Sebastien CONAN
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
 * A box to store tiny-whoops.
 *
 * Cupboard that will contain several tiny-whoops and their surrounding
 * protection boxes. This should be printed in rigid a material, like PLA
 * or PETG.
 *
 * @author jsconan
 * @version 0.1.0
 */

// Import the project's setup.
include <util/setup.scad>

// Displays a build box visualization to preview the printer area.
buildBox(center=true);

// Sets the minimum facet angle and size using the defined render mode.
applyMode(mode=renderMode) {
    // Uncomment the next line to cut a sample from the object
    //sample(size=[DEFAULT_BUILD_PLATE_SIZE, DEFAULT_BUILD_PLATE_SIZE, 5], offset=[0, 0, 20])
    whoopCupboard(
        whoopType = whoopType,
        whoopCount = whoopCountDrawer,
        drawerWallThickness = getBoxWallThickness(DRAWER),
        drawerHeight = getBoxHeight(CUPBOARD, whoopType),
        drawerCount = drawerCountCupboard,
        drawerDistance = getBoxWallDistance(CUPBOARD),
        ductDistance = getBoxWhoopDistance(DRAWER),
        wallThickness = getBoxWallThickness(CUPBOARD)
    );
}
