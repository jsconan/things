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
 * Defines some special track parts.
 *
 * @author jsconan
 */

/**
 * Draws the shape of a clip that will clamp a barrier border.
 * @param Number thickness - The thickness of the barrier body.
 * @param Number base - The base unit value used to design the barrier holder.
 * @param Number wall - The thickness of the outline.
 */
module archTowerClip(thickness, base, wall) {
    holderHeight = getBarrierHolderHeight(base);
    indent = getBarrierStripIndent(base);

    rotateZ(-90) {
        difference() {
            clip(
                wall = wall,
                height = holderHeight,
                base = base,
                thickness = thickness,
                distance = printTolerance
            );
            translate([0, wall / 2, holderHeight - indent]) {
                box([thickness, wall * 2, indent * 2]);
            }
        }
    }
}

/**
 * Draws the shape of a male arch tower that will clamp a barrier border.
 * @param Number length - The length of a track element.
 * @param Number thickness - The thickness of the barrier body.
 * @param Number base - The base unit value used to design the barrier holder.
 * @param Number wall - The thickness of the outline.
 */
module archTowerMale(length, thickness, base, wall) {
    thickness = thickness + printTolerance;
    linkHeight = getBarrierHolderLinkHeight(base);
    indent = getBarrierStripIndent(base);
    length = length / 2;

    translateX(length / 2) {
        archTowerClip(
            thickness = thickness,
            base = base,
            wall = wall
        );
    }
    carveBarrierNotch(length=length, thickness=thickness, base=base, notches=1) {
        straightLinkMale(length=length, linkHeight=linkHeight, base=base) {
            extrudeStraightProfile(length=length) {
                barrierHolderProfile(
                    base = base,
                    thickness = thickness
                );
            }
        }
    }
}

/**
 * Draws the shape of a female arch tower that will clamp a barrier border.
 * @param Number length - The length of a track element.
 * @param Number thickness - The thickness of the barrier body.
 * @param Number base - The base unit value used to design the barrier holder.
 * @param Number wall - The thickness of the outline.
 */
module archTowerFemale(length, thickness, base, wall) {
    thickness = thickness + printTolerance;
    linkHeight = getBarrierHolderLinkHeight(base);
    indent = getBarrierStripIndent(base);
    length = length / 2;

    translateX(length / 2) {
        archTowerClip(
            thickness = thickness,
            base = base,
            wall = wall
        );
    }
    rotateZ(180) {
        carveBarrierNotch(length=length, thickness=thickness, base=base, notches=1) {
            straightLinkFemale(length=length, linkHeight=linkHeight, base=base) {
                extrudeStraightProfile(length=length) {
                    barrierHolderProfile(
                        base = base,
                        thickness = thickness
                    );
                }
            }
        }
    }
}

/**
 * Draws the shape of a connector between a barrier holder and a unibody barrier.
 * @param Number length - The length of a track element.
 * @param Number height - The height of the barrier.
 * @param Number thickness - The thickness of the barrier body.
 * @param Number base - The base unit value used to design the barrier holder.
 */
module barrierHolderToUnibodyConnector(length, height, thickness, base) {
    holderTopWidth = getBarrierHolderTopWidth(base, thickness);
    holderWidth = getBarrierHolderWidth(base);
    holderHeight = getBarrierHolderHeight(base);
    holderLinkHeight = getBarrierHolderLinkHeight(base);
    unibodyWidth = getBarrierUnibodyWidth(base);
    unibodyLineX = (unibodyWidth - holderTopWidth) / 2 - base / 4;
    unibodyLineY = height - holderHeight - base * 1.75;
    holderLineY = holderHeight - base * 1.25;
    unibodyTopWidth = unibodyWidth - base / 2 - holderLineY * (unibodyLineX / unibodyLineY) * 2;
    length = length / 2;

    distribute(intervalX=length, center=true) {
        difference() {
            extrudeStraightProfile(length=length) {
                barrierUnibodyProfile(
                    height = height,
                    base = base,
                    thickness = thickness
                );
            }
            translate([length / 2, 0, height - holderLinkHeight]) {
                barrierLink(
                    height = holderLinkHeight + printResolution + 1,
                    base = base,
                    distance = printTolerance
                );
            }
        }
        carveBarrierNotch(length=length, thickness=thickness, base=base, notches=1) {
            translateX(-length / 2) {
                rotate([90, 0, 90]) {
                    repeatMirror() {
                        simplePolyhedron(
                            bottom = reverse(getBarrierHolderProfilePoints(
                                base = base,
                                bottomWidth = unibodyWidth,
                                topWidth = unibodyTopWidth
                            )),
                            top = reverse(getBarrierHolderProfilePoints(
                                base = base,
                                bottomWidth = holderWidth,
                                topWidth = holderTopWidth
                            )),
                            z = length
                        );
                    }
                }
            }
        }
    }
}

/**
 * Draws the shape of a male connector between a barrier holder and a unibody barrier.
 * @param Number length - The length of a track element.
 * @param Number height - The height of the barrier.
 * @param Number thickness - The thickness of the barrier body.
 * @param Number base - The base unit value used to design the barrier holder.
 */
module barrierHolderToUnibodyMale(length, height, thickness, base) {
    thickness = thickness + printTolerance;
    holderLinkHeight = getBarrierHolderLinkHeight(base);
    unibodyLinkHeight = getBarrierUnibodyLinkHeight(height, base);

    straightLinkMale(length=length, linkHeight=unibodyLinkHeight, base=base) {
        straightLinkFemale(length=length, linkHeight=holderLinkHeight, base=base) {
            barrierHolderToUnibodyConnector(
                length = length,
                height = height,
                thickness = thickness,
                base = base
            );
        }
    }
}

/**
 * Draws the shape of a female connector between a barrier holder and a unibody barrier.
 * @param Number length - The length of a track element.
 * @param Number height - The height of the barrier.
 * @param Number thickness - The thickness of the barrier body.
 * @param Number base - The base unit value used to design the barrier holder.
 */
module barrierHolderToUnibodyFemale(length, height, thickness, base) {
    thickness = thickness + printTolerance;
    holderLinkHeight = getBarrierHolderLinkHeight(base);
    unibodyLinkHeight = getBarrierUnibodyLinkHeight(height, base);

    straightLinkFemale(length=length, linkHeight=unibodyLinkHeight, base=base) {
        straightLinkMale(length=length, linkHeight=holderLinkHeight, base=base) {
            rotateZ(180) {
                barrierHolderToUnibodyConnector(
                    length = length,
                    height = height,
                    thickness = thickness,
                    base = base
                );
            }
        }
    }
}

/**
 * Draws the shape of a male connector for a barrier holder.
 * @param Number length - The length of a track element.
 * @param Number thickness - The thickness of the barrier body.
 * @param Number base - The base unit value used to design the barrier holder.
 */
module barrierHolderConnectorMale(length, thickness, base) {
    thickness = thickness + printTolerance;
    linkHeight = getBarrierHolderLinkHeight(base);
    length = length / 2;

    carveBarrierNotch(length=length, thickness=thickness, base=base, notches=1) {
        straightLinkMale(length=length, linkHeight=linkHeight, base=base) {
            rotateZ(180) {
                straightLinkMale(length=length, linkHeight=linkHeight, base=base) {
                    extrudeStraightProfile(length=length) {
                        barrierHolderProfile(
                            base = base,
                            thickness = thickness
                        );
                    }
                }
            }
        }
    }
}

/**
 * Draws the shape of a female connector for a barrier holder.
 * @param Number length - The length of a track element.
 * @param Number thickness - The thickness of the barrier body.
 * @param Number base - The base unit value used to design the barrier holder.
 */
module barrierHolderConnectorFemale(length, thickness, base) {
    thickness = thickness + printTolerance;
    linkHeight = getBarrierHolderLinkHeight(base);
    length = length / 2;

    carveBarrierNotch(length=length, thickness=thickness, base=base, notches=1) {
        straightLinks(length=length, linkHeight=linkHeight, base=base) {
            extrudeStraightProfile(length=length) {
                barrierHolderProfile(
                    base = base,
                    thickness = thickness
                );
            }
        }
    }
}
