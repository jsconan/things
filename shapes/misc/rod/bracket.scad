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
 * Defines the shapes for the rod bracket.
 *
 * @author jsconan
 */

/**
 * Gets the outline of the bracket's profile
 * @param Vector|Number rodDiameter
 * @param Number rodWidth
 * @param Number rodThickness
 * @param Number panelWidth
 * @param Number height
 * @param Number thickness
 * @param Number hookHeight
 * @param Number hookThickness
 */
function getRodBracketProfilePoints(rodDiameter, rodWidth, rodThickness, panelWidth, height, thickness, hookHeight, hookThickness) =
    let(
        rodThickness = rodThickness + printTolerance,
        radius = vadd(vector2D(rodDiameter / 2), printTolerance),
        radiusOut = vadd(radius, thickness),

        rodRoundAngle = getChordAngle(length=rodThickness, radius=radius[0]),
        rodRoundDistance = getChordDistance(angle=rodRoundAngle, radius=radius[0]),
        rodRoundStartAngle = (180 - rodRoundAngle) / 2,

        rodRoundAngleOut = getChordAngle(length=rodThickness + thickness*2, radius=radiusOut[0]),
        rodRoundDistanceOut = getChordDistance(angle=rodRoundAngleOut, radius=radiusOut[0]),
        rodRoundStartAngleOut = (180 - rodRoundAngleOut) / 2,

        filletRod = thickness / 2,
        filletHook = hookThickness / 2,
        filletOut = thickness,
        filletIn = 1,
        innerHeight = height - filletOut - radiusOut[1],
        innerWidth = panelWidth - filletIn * 2,
        outerWidth = hookThickness + thickness + panelWidth - filletOut * 2,
        hookInnerHeight = hookHeight - filletIn - filletHook,
        hookOuterHeight = hookHeight + thickness - filletOut - filletHook,
        rodHookInnerHeight = rodWidth - radius[1] - filletOut,
        startX = 0,
        startY = height / 2 - thickness - filletIn
    )
    path([
        ["P", startX, startY],
        ["C", filletIn, 0, 90],
        ["H", -innerWidth],
        ["C", filletIn, 90, 180],
        ["V", -hookInnerHeight],
        ["C", filletHook, 360, 180],
        ["V", hookOuterHeight],
        ["C", filletOut, 180, 90],
        ["H", outerWidth],
        ["C", filletOut, 90, 0],
        ["V", -innerHeight - rodRoundDistance],
        ["C", radius, 180 + rodRoundStartAngle, 360 - rodRoundStartAngle],
        ["V", rodHookInnerHeight + rodRoundDistance],
        ["C", filletRod, 180, 0],
        ["V", -rodHookInnerHeight - rodRoundDistanceOut],
        ["C", radiusOut, 360 - rodRoundStartAngleOut, 180 + rodRoundStartAngleOut]
    ])
;

/**
 * Draws the outline of the bracket's profile
 * @param Vector|Number rodDiameter
 * @param Number rodWidth
 * @param Number panelWidth
 * @param Number rodThickness
 * @param Number height
 * @param Number thickness
 * @param Number hookHeight
 * @param Number hookThickness
 */
module rodBracketProfile(rodDiameter, rodWidth, rodThickness, panelWidth, height, thickness, hookHeight, hookThickness) {
    polygon(
        points = getRodBracketProfilePoints(
            rodDiameter = rodDiameter,
            rodWidth = rodWidth,
            rodThickness = rodThickness,
            panelWidth = panelWidth,
            height = height,
            thickness = thickness,
            hookHeight = hookHeight,
            hookThickness = hookThickness
        ),
        convexity = 10
    );
}

/**
 * Draws a rod bracket
 * @param Vector|Number rodDiameter
 * @param Number rodWidth
 * @param Number panelWidth
 * @param Number rodThickness
 * @param Number width
 * @param Number height
 * @param Number thickness
 * @param Number hookHeight
 * @param Number hookThickness
 */
module rodBracket(rodDiameter, rodWidth, rodThickness, panelWidth, width, height, thickness, hookHeight, hookThickness) {
    linear_extrude(height=width, center=true, convexity=10) {
        rodBracketProfile(
            rodDiameter = rodDiameter,
            rodWidth = rodWidth,
            rodThickness = rodThickness,
            panelWidth = panelWidth,
            height = height,
            thickness = thickness,
            hookHeight = hookHeight,
            hookThickness = hookThickness
        );
    }
}
