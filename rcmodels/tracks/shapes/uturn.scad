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
 * Defines the U-turn track parts.
 *
 * @author jsconan
 */

/**
 * Draws the shape of a barrier border for a U-Turn.
 * @param Number length - The length of a track element.
 * @param Number height - The height of the barrier.
 * @param Number thickness - The thickness of the barrier body.
 * @param Number base - The base unit value used to design the barrier holder.
 * @param Number gap - The distance between the two side of the u-turn.
 * @param Number right - Is it the right or the left part of the track element that is added first?
 */
module uTurnBarrierHolder(length, height, thickness, base, gap, right = false) {
    adjustedThickness = thickness + printTolerance;
    holderWidth = getBarrierHolderWidth(base);
    holderHeight = getBarrierHolderHeight(base);
    towerWidth = nozzleAligned(adjustedThickness + minWidth);
    towerHeight = getBarrierBodyInnerHeight(height, base) / 2;
    interval = (holderWidth + gap) / 2;

    difference() {
        union() {
            translateY(interval) {
                rotateZ(right ? 180 : 0) {
                    straightBarrierHolder(
                        length = length,
                        thickness = thickness,
                        base = base
                    );
                }
            }
            translateY(-interval) {
                rotateZ(right ? 0 : 180) {
                    straightBarrierHolder(
                        length = length,
                        thickness = thickness,
                        base = base
                    );
                }
            }
        }
        translate([length, 0, -length]) {
            box(length * 2);
        }
    }
    rotateZ(270) {
        rotate_extrude(angle=180, convexity=10) {
            translateX(interval) {
                barrierHolderProfile(
                    base = base,
                    thickness = adjustedThickness
                );
                translate([-adjustedThickness / 2, holderHeight + towerHeight / 2]) {
                    rectangle([towerWidth, towerHeight]);
                }
            }
        }
    }
}

/**
 * Draws the shape of a barrier unibody for a U-Turn.
 * @param Number length - The length of a track element.
 * @param Number height - The height of the barrier.
 * @param Number thickness - The thickness of the barrier body for a barrier holder.
 * @param Number base - The base unit value used to design the barrier holder.
 * @param Number gap - The distance between the two side of the u-turn.
 * @param Number right - Is it the right or the left part of the track element that is added first?
 */
module uTurnBarrierUnibody(length, height, thickness, base, gap, right = false) {
    interval = (getBarrierUnibodyWidth(base) + gap) / 2;

    difference() {
        union() {
            translateY(interval) {
                rotateZ(right ? 180 : 0) {
                    straightBarrierUnibody(
                        length = length,
                        height = height,
                        thickness = thickness,
                        base = base
                    );
                }
            }
            translateY(-interval) {
                rotateZ(right ? 0 : 180) {
                    straightBarrierUnibody(
                        length = length,
                        height = height,
                        thickness = thickness,
                        base = base
                    );
                }
            }
        }
        translate([length, 0, -length]) {
            box(length * 2);
        }
    }
    rotateZ(270) {
        rotate_extrude(angle=180, convexity=10) {
            translateX(interval) {
                barrierUnibodyProfile(
                    height = height,
                    base = base,
                    thickness = thickness + printTolerance
                );
            }
        }
    }
}

/**
 * Draws the shape of a barrier border for a U-Turn.
 * @param Number thickness - The thickness of the barrier body.
 * @param Number base - The base unit value used to design the barrier holder.
 * @param Number gap - The distance between the two side of the u-turn.
 */
module uTurnCompensationBarrierHolder(thickness, base, gap) {
    holderWidth = getBarrierHolderWidth(base);
    holderHeight = getBarrierHolderHeight(base);
    length = holderWidth + gap;
    indent = getBarrierStripIndent(base);
    height = holderHeight - indent;
    thickness = thickness + printTolerance;

    difference() {
        straightBarrierMain(
            length = length,
            thickness = thickness,
            base = base
        );
        translateZ(height) {
            box([length + 2, thickness, indent * 2]);
        }
    }
}

/**
 * Draws the shape of a barrier border for a U-Turn.
 * @param Number height - The height of the barrier.
 * @param Number thickness - The thickness of the barrier body.
 * @param Number base - The base unit value used to design the barrier holder.
 * @param Number gap - The distance between the two side of the u-turn.
 */
module uTurnCompensationBarrierUnibody(height, thickness, base, gap) {
    length = getBarrierHolderWidth(base) + gap;

    straightBarrierUnibody(
        length = length,
        height = height,
        thickness = thickness,
        base = base
    );
}

/**
 * Draws the shape of a barrier body.
 * @param Number length - The length of the track element.
 * @param Number height - The height of the barrier.
 * @param Number thickness - The thickness of the barrier body.
 * @param Number base - The base unit value used to design the barrier holder.
 * @param Number gap - The distance between the two side of the u-turn.
 */
module uTurnCompensationBarrierBody(length, height, thickness, base, gap) {
    holderWidth = getBarrierHolderWidth(base);
    strip = getBarrierStripHeight(base);
    indent = getBarrierStripIndent(base);
    stripHeight = strip - indent;
    compensation = holderWidth + gap;
    compensedLength = length + compensation;
    interval = length / 2;

    difference() {
        box(
            size = [compensedLength, height, thickness],
            center = true
        );
        repeatMirror(interval=[0, height, 0], axis=[0, 1, 0], center=true) {
            repeatMirror() {
                translateX((compensedLength - interval) / 2) {
                    barrierNotch(
                        thickness = thickness * 2,
                        base = base,
                        distance = printTolerance,
                        interval = interval,
                        count = 2,
                        center = true
                    );
                }
            }
            box(
                size = [compensation, stripHeight * 2, thickness + 1],
                center = true
            );
        }
    }
}
