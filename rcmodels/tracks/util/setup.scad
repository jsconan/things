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
 * A 1/24 RC track system.
 *
 * Setup the context.
 *
 * @author jsconan
 * @version 0.1.0
 */

// As we need to use some shapes, use the right entry point of the library.
include <../../../lib/camelSCAD/shapes.scad>

// Then we need the config for the project, as well as the related functions
include <../config/config.scad>
include <functions.scad>

// Finally, include the shapes
include <../shapes/profiles.scad>
include <../shapes/straight.scad>
include <../shapes/curve.scad>

// Validate the critical constraints
assert(
    chunkLength >= getMinStraightLength(),
    str(
        "The length for a track chunk is too small! The minimum length for a straight element is ",
        getMinStraightLength(),
        ". The current value is ",
        chunkLength
    )
);
assert(
    getArcLength(radius = chunkLength, angle = 90) >= getMinCurveLength(),
    str(
        "The length for a track chunk is too small! The minimum arc length for a curved element is ",
        getMinCurveLength(),
        ". The current value is ",
        getArcLength(radius = chunkLength, angle = 90)
    )
);
