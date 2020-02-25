/**
 * @license
 * GPLv3 License
 *
 * Copyright (c) 2020 Jean-Sebastien CONAN
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
 * A race track system for 1/24 to 1/32 scale RC cars.
 *
 * Test the special elements shapes.
 *
 * @author jsconan
 */

// Import the project's setup.
include <setup.scad>

// Sets the minimum facet angle and size using the defined render mode.
applyMode(mode=mode) {

    distributeGrid(intervalX=[length * 1.5, 0, 0], intervalY=[0, height * 1.5, 0], line=3, center=true) {

        // test the arch tower shape with holders, left side
        archTower(
            length = length,
            thickness = thickness,
            base = base,
            wall = wall * 2,
            right = false
        );

        // test the arch tower shape with holders, right side
        archTower(
            length = length,
            thickness = thickness,
            base = base,
            wall = wall * 2,
            right = true
        );

    }
}