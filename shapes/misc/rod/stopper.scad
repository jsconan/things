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
 * Defines the shapes for the rod stoppers.
 *
 * @author jsconan
 */

/**
 * Draws a rod stopper
 * @param Number width
 * @param Number height
 * @param Number diameter
 * @param Number thickness
 */
module rodStopper(width, height, diameter, thickness, rodWidth, rodDiameter) {
    diameter = vector2D(diameter);
    stopperWidth = diameter[0];
    stopperHeight = max(height, diameter[1] + rodWidth);
    rodLength = width - stopperWidth;

    translateX(-rodLength / 2) {
        linear_extrude(height=thickness, center=true, convexity=10) {
            stadium(
                w = stopperWidth,
                h = stopperHeight,
                d = diameter
            );
        }
        translateX((diameter[0] + rodLength) / 2) {
            rodBody(
                diameter = rodDiameter,
                length = rodLength,
                width = rodWidth,
                thickness = thickness
            );
        }
    }
}

/**
 * Draws a rod stopper with a male connector
 * @param Number width
 * @param Number height
 * @param Number diameter
 * @param Number thickness
 * @param Number rodWidth
 */
module rodStopperMale(width, height, diameter, thickness, rodWidth, rodDiameter) {
    linkBase = rodWidth / 4;
    translateX(-width / 2) {
        link(
            neck = linkBase,
            bulb = linkBase,
            height = thickness,
            center = true
        );
    }
    rotateZ(180) {
        rodStopper(
            width = width,
            height = height,
            diameter = diameter,
            thickness = thickness,
            rodWidth = rodWidth,
            rodDiameter = rodDiameter
        );
    }
}

/**
 * Draws a rod stopper with a female connector
 * @param Number width
 * @param Number height
 * @param Number diameter
 * @param Number thickness
 * @param Number rodWidth
 */
module rodStopperFemale(width, height, diameter, thickness, rodWidth, rodDiameter) {
    linkBase = rodWidth / 4;
    difference() {
        rodStopper(
            width = width,
            height = height,
            diameter = diameter,
            thickness = thickness,
            rodWidth = rodWidth,
            rodDiameter = rodDiameter
        );
        translateX(width / 2) {
            link(
                neck = linkBase,
                bulb = linkBase,
                height = thickness + 1,
                distance = printTolerance,
                center = true
            );
        }
    }
}
