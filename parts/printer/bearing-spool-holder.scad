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
 * A sleeve to adapt on a ball bearing axle for a spool holder.
 *
 * @author jsconan
 */

// Import the project's setup.
include <../../config/setup.scad>

// Defines the constraints of the object.
spoolDiameter = 50;
bearingDiameter = 30;
bearingWidth = 9;
bearingAxle = 18;
flange = 10;
plate = 5;
tread = 35;
chamfer = 1;

// Defines the dimensions of the object.
height = tread + plate;
flangeDiameter = spoolDiameter + flange * 2;
topBrim = (spoolDiameter - bearingAxle) / 2 - chamfer * 2;
bottomBrim = (flangeDiameter - bearingDiameter) / 2 - chamfer * 2;
innerFlange = flange - chamfer;
innerTread = tread - chamfer;
innerPlate = plate - chamfer * 2;
innerBearing = bearingWidth - chamfer;
innerAxle = height - bearingWidth - chamfer;

startX = bearingDiameter / 2;
startY = bearingWidth;

// Sets the minimum facet angle and size using the defined render mode.
applyMode(mode=renderMode) {
    rotate_extrude() {
        polygon(
            points=path([
                ["P", startX, startY],
                ["H", -startX],
                ["V", layerHeight],
                ["H", bearingAxle / 2],
                ["V", innerAxle - layerHeight],
                ["L", chamfer, chamfer],
                ["H", topBrim],
                ["L", chamfer, -chamfer],
                ["V", -innerTread],
                ["H", innerFlange],
                ["L", chamfer, -chamfer],
                ["V", -innerPlate],
                ["L", -chamfer, -chamfer],
                ["H", -bottomBrim],
                ["L", -chamfer, chamfer],
                ["V", bearingWidth]
            ]),
            convexity=10
        );
    }
}
