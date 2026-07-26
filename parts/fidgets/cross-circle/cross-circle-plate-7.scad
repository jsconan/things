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
 * A cross-circle fidget.
 *
 * @author jsconan
 */

// Import the project's setup.
include <../../../config/fidgets/cross-circle/setup.scad>

big_connectors = 7;

applyMode(mode=renderMode) {
    cross_circle_plate(n=9, connectors=big_connectors);
    cross_circle_plate(n=9, connectors=4, size=cross_circle_diameter(connectors=big_connectors));
    cross_circle_plate(n=4, connectors=3, size=cross_circle_diameter(connectors=big_connectors));
}
