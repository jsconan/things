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
 * * Setup the context and define the config for the tests.
 *
 * @author jsconan
 * @version 0.2.0
 */

// Import the project's setup.
include <../config/setup.scad>

// Defines the test config
mode = MODE_DEV;        // The render quality to apply
length = 50;            // The nominal size of a track element
width = 100;            // The width of track lane
height = 30;            // The height of the barrier, including the holders
base = 2;               // The base unit value used to design the barrier holder
thickness = 0.6;        // The thickness of the barrier body
wall = 0.8;             // The thickness of the walls
clip = 2;               // The thickness of the wire clips

// Validate the config against the constraints
validateConfig(length, width, height, base);