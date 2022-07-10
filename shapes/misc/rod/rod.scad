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
 * Defines the shapes for the rod.
 *
 * @author jsconan
 */

/**
 * Gets the outline of the rod's profile
 * @param Vector|Number diameter
 * @param Number width
 * @param Number thickness
 */
function getRodProfilePoints(diameter, width, thickness) =
    let(
        diameter = vector2D(diameter),
        thickness = min(thickness, diameter[0]),
        radius = diameter / 2,
        origin = [0, max(0, max(diameter[1], width) - diameter[1])] / 2,
        angle1 = (180 - getChordAngle(length=thickness, radius=radius[0])) / 2,
        angle2 = 180 - angle1,
        angle3 = 180 + angle1,
        angle4 = 180 + angle2
    )
    concat(
        arc(r=radius, o=origin, a1=angle1, a2=angle2),
        arc(r=radius, o=-origin, a1=angle3, a2=angle4)
    )
;

/**
 * Draws the outline of the rod's profile
 * @param Vector|Number diameter
 * @param Number width
 * @param Number thickness
 * @param Number distance
 */
module rodProfile(diameter, width, thickness, distance = 0) {
    polygon(
        points = outline(
            points = getRodProfilePoints(
                diameter = diameter,
                width = width,
                thickness = thickness
            ),
            distance = distance
        ),
        convexity = 10
    );
}

/**
 * Draws a rod
 * @param Vector|Number diameter
 * @param Number length
 * @param Number width
 * @param Number thickness
 */
module rodBody(diameter, length, width, thickness) {
    rotateY(90) {
        linear_extrude(height=length, center=true, convexity=10) {
            rodProfile(
                diameter = diameter,
                width = width,
                thickness = thickness
            );
        }
    }
}

/**
 * Draws a rod
 * @param Vector|Number diameter
 * @param Number length
 * @param Number width
 * @param Number thickness
 */
module rod(diameter, length, width, thickness) {
    linkBase = width / 4;
    translateX(-length / 2) {
        link(
            neck = linkBase,
            bulb = linkBase,
            height = thickness,
            center = true
        );
    }
    difference() {
        rodBody(
            diameter = diameter,
            length = length,
            width = width,
            thickness = thickness
        );
        translateX(length / 2) {
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

/**
 * Draws a rod sleeve
 * @param Vector|Number diameter
 * @param Number thickness
 * @param Number width
 * @param Number sleeveLength
 * @param Number sleeveThickness
 */
module rodSleeve(diameter, width, thickness, sleeveLength, sleeveThickness) {
    distance = printTolerance / 2;
    linear_extrude(height=sleeveLength, center=true, convexity=10) {
        difference() {
            rodProfile(
                diameter = diameter,
                width = width,
                thickness = thickness,
                distance = distance + sleeveThickness
            );
            rodProfile(
                diameter = diameter,
                width = width,
                thickness = thickness,
                distance = distance
            );
        }
    }
}
