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
 * Part of the cross-circle fidget project.
 *
 * Configuration for the project.
 *
 * @author jsconan
 */

// Defines the constraints of the object.
base_diameter = 20.0;   // The base diameter of the cross-circle.
nb_connectors = 4;      // The number of connectors to be placed around the circle.
min_connectors = 3;     // The minimum number of connectors to be placed around the circle.
max_connectors = 20;    // The maximum number of connectors to be placed around the circle.

inner_margin = 5;       // The margin between the cross-circles when placed on a plate.
outer_margin = 2;       // The margin between groups of cross-circles when placed on a plate.

/**
 * Computes the diameter of the cross-circle based on the number of connectors and the base diameter.
 *
 * @param connectors The number of connectors to be placed around the circle.
 * @param base_diameter The base diameter of the cross-circle.
 * @return The computed diameter of the cross-circle.
 */
function cross_circle_diameter(connectors=nb_connectors, base_diameter=base_diameter) =
    base_diameter * min(max_connectors, max(4, connectors)) / 4;

/**
 * Computes the number of connectors to be placed around the circle based on the defined constraints.
 *
 * @param connectors The desired number of connectors to be placed around the circle.
 * @return The computed number of connectors to be placed around the circle, constrained by the defined minimum and maximum values.
 */
function cross_circle_connectors(connectors=nb_connectors) =
    min(max(min_connectors, connectors), max_connectors);

/**
 * Computes the width of a plate based on the number of cross-circles, the number of connectors,
 * and the defined margin.
 *
 * @param n The number of cross-circles to be placed on the plate in one dimension.
 * @param connectors The number of connectors to be placed around each cross-circle.
 * @param margin The margin between the cross-circles.
 * @return The computed width of the plate.
 */
function plate_width(n=4, connectors=nb_connectors, margin=inner_margin) =
    n * cross_circle_diameter(connectors=connectors) + (n - 1) * margin;
