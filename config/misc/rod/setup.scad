/**
 * @license
 * GPLv3 License
 *
 * Copyright (c) 2020-2022 Jean-Sebastien CONAN
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
 * A curtain rod system.
 *
 * Setup the context.
 *
 * @author jsconan
 */

// Import the project's setup.
include <../../setup.scad>

// Then we need the config for the project, as well as the related functions
include <config.scad>

// Finally, include the shapes
include <../../../shapes/misc/rod/rod.scad>
include <../../../shapes/misc/rod/stopper.scad>
include <../../../shapes/misc/rod/bracket.scad>
