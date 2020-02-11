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
 * Defines the profile shapes for the track elements.
 *
 * @author jsconan
 */

/**
 * Computes the points defining the profile of a barrier link.
 * @param Number base - The base unit value used to design the barrier holder.
 * @param Number [distance] - An additional distance added to the outline of the barrier link.
 * @returns Vector[]
 */
function getBarrierLinkPoints(base, distance = 0) =
    let(
        half = base / 2
    )
    outline(path([
        ["P", half, half],
        ["H", -base],
        ["C", [half, half], 0, 180],
        ["V", -base],
        ["C", [half, half], 180, 360],
        ["H", base],
    ]), distance)
;

/**
 * Draws the profile of a barrier link.
 * @param Number base - The base unit value used to design the barrier holder.
 * @param Number [distance] - An additional distance added to the outline of the barrier link.
 */
module barrierLinkProfile(base, distance = 0) {
    polygon(getBarrierLinkPoints(
        base = base,
        distance = distance
    ), convexity = 10);
}

/**
 * Computes the points defining the profile of a barrier holder notch.
 * @param Number base - The base unit value used to design the barrier holder.
 * @param Number [distance] - An additional distance added to the outline of the barrier link.
 * @returns Vector[]
 */
function getBarrierNotchPoints(base, distance = 0) =
    let(
        width = getBarrierNotchWidth(base, distance),
        top = getBarrierNotchDistance(base, distance),
        strip = getBarrierStripHeight(base),
        indent = getBarrierStripIndent(base),
        height = strip - indent
    )
    path([
        ["P", -width / 2, 0],
        ["L", indent, height],
        ["H", top],
        ["L", indent, -height],
        ["V", -base],
        ["H", -width]
    ])
;

/**
 * Draws the profile of a barrier holder notch.
 * @param Number base - The base unit value used to design the barrier holder.
 * @param Number [distance] - An additional distance added to the outline of the barrier link.
 */
module barrierNotchProfile(base, distance = 0) {
    polygon(getBarrierNotchPoints(
        base = base,
        distance = distance
    ), convexity = 10);
}

/**
 * Computes the points defining the profile of a barrier holder.
 * @param Number base - The base unit value used to design the barrier holder.
 * @param Number thickness - The thickness of the barrier body.
 * @returns Vector[]
 */
function getBarrierHolderPoints(base, thickness) =
    let(
        linkWidth = getBarrierLinkWidth(base, printTolerance),
        top = getBarrierHolderTopWidth(base, thickness),
        width = getBarrierHolderWidth(base),
        height = getBarrierHolderHeight(base),
        offset = getBarrierHolderOffset(base),
        lineW = (width - top) / 2,
        lineH = height - base
    )
    path([
        ["P", -width / 2 + offset, 0],
        ["L", -offset, offset],
        ["V", base - offset],
        ["L", lineW - offset, lineH - offset],
        ["L", offset, offset],
        ["H", top],
        ["L", offset, -offset],
        ["L", lineW - offset, -lineH + offset],
        ["V", -base + offset],
        ["L", -offset, -offset]
    ])
;

/**
 * Draws the profile of a barrier holder.
 * @param Number base - The base unit value used to design the barrier holder.
 * @param Number thickness - The thickness of the barrier body.
 */
module barrierHolderProfile(base, thickness) {
    polygon(getBarrierHolderPoints(
        base = base,
        thickness = thickness
    ), convexity = 10);
}

/**
 * Draws the outline of a barrier holder.
 * @param Number wall - The thickness of the outline.
 * @param Number base - The base unit value used to design the barrier holder.
 * @param Number thickness - The thickness of the barrier body.
 * @param Number [distance] - An additional distance added to the outline of the profile.
 */
module barrierHolderOutline(wall, base, thickness, distance = 0) {
    translateY(wall) {
        difference() {
            profile = outline(getBarrierHolderPoints(
                base = base,
                thickness = thickness
            ), -distance);

            polygon(outline(profile, -wall), convexity = 10);
            polygon(profile, convexity = 10);
        }
    }
}

/**
 * Draws the profile of a clip for a barrier holder.
 * @param Number wall - The thickness of the outline.
 * @param Number base - The base unit value used to design the barrier holder.
 * @param Number thickness - The thickness of the barrier body.
 */
module clipProfile(wall, base, thickness) {
    holderHeight = getBarrierHolderHeight(base);

    difference() {
        barrierHolderOutline(
            wall = wall,
            base = base,
            thickness = thickness,
            distance = 0
        );

        translateY(holderHeight + wall * 1.5) {
            rectangle([getBarrierHolderTopWidth(base, thickness), wall * 2]);
        }
    }
}
