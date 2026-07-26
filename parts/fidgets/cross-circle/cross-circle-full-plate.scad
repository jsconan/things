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

applyMode(mode=renderMode) {
    translate([
        -plate_width(n=3, connectors=8) - outer_margin,
        plate_width(n=3, connectors=8) + outer_margin
    ] / 2) {
        cross_circle_plate(n=9, connectors=8);
        cross_circle_plate(n=9, connectors=4, size=cross_circle_diameter(connectors=8));
        cross_circle_plate(n=4, connectors=3, size=cross_circle_diameter(connectors=8));
    }
    translate([
        plate_width(n=3, connectors=7) + outer_margin,
        plate_width(n=3, connectors=7) + outer_margin
    ] / 2) {
        cross_circle_plate(n=9, connectors=7);
        cross_circle_plate(n=9, connectors=4, size=cross_circle_diameter(connectors=7));
        cross_circle_plate(n=4, connectors=3, size=cross_circle_diameter(connectors=7));
    }
    translateX((-plate_width(n=3, connectors=6, margin=outer_margin) - outer_margin) / 2) {
        translateY((-plate_width(n=2, connectors=6, margin=outer_margin) - outer_margin) / 2) {
            cross_circle_plate(n=6, connectors=6, line=3, margin=outer_margin);
        }
        translate([
            -plate_width(n=3, connectors=6, margin=outer_margin) - outer_margin - plate_width(n=1, connectors=3),
            -plate_width(n=2, connectors=3, margin=outer_margin) - outer_margin
        ] / 2) {
            cross_circle_plate(n=2, connectors=3, line=1, margin=outer_margin);
        }
    }
    translateX((plate_width(n=3, connectors=5, margin=outer_margin) + outer_margin) / 2) {
        translateY((-plate_width(n=2, connectors=5, margin=outer_margin) - outer_margin) / 2) {
            cross_circle_plate(n=6, connectors=5, line=3, margin=outer_margin);
        }
        translate([
            plate_width(n=3, connectors=5, margin=outer_margin) + outer_margin + plate_width(n=1, connectors=3, margin=outer_margin),
            -plate_width(n=2, connectors=3, margin=outer_margin) - outer_margin
        ] / 2) {
            cross_circle_plate(n=2, connectors=3, line=1, margin=outer_margin);
        }
    }
}
