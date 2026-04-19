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
 * Parts for a sleeve that fits over the leg of a LACK table and can receive an adjustable leveling foot.
 *
 * @author jsconan
 *
 * External global variables used in this file (see config files for details):
 * - foot_plate_thickness
 * - leg_sleeve_depth
 * - leg_sleeve_facets
 * - leg_sleeve_fastening_height
 * - leg_sleeve_fastening_offset
 * - leg_sleeve_thickness
 * - m3_screw_diameter
 * - m3_screw_head_diameter
 * - m8_screw_diameter
 * - m8_screw_head_hex_size
 * - m8_screw_head_thickness
 * - m8_screw_length
 * - m8_screw_nut_hex_size
 * - m8_screw_nut_lp_thickness
 * - m8_screw_nut_thickness
 * - m8_screw_washer_diameter
 * - m8_screw_washer_thickness
 * - table_leg_fillet_radius
 * - table_leg_width
 */

/**
 * The height of the body of the leg sleeve part between the leveling foot and the point where the
 * table leg takes place.
 * @param Number plate_thickness - the height of the plate that will receive the screw.
 * @param Number lead_screw_length - the length of the lead screw.
 * @param Number lead_screw_lock_nut_height - the height of the lock nut on the lead screw.
 * @param Number lead_screw_washer_height - the height of the washer on the lead screw.
 */
function leg_sleeve_mount_height(
    plate_thickness = foot_plate_thickness,
    lead_screw_length = m8_screw_length,
    lead_screw_lock_nut_height = m8_screw_nut_lp_thickness,
    lead_screw_washer_height = m8_screw_washer_thickness,
) = (
    plate_thickness +
    lead_screw_length -
    adjustToLayerHeight(lead_screw_lock_nut_height + lead_screw_washer_height + plate_thickness)
);

/**
 * The height of a leg sleeve that can receive an adjustable leveling foot.
 * @param Number sleeve_depth - the depth of the sleeve.
 * @param Number plate_thickness - the height of the plate that will receive the screw.
 * @param Number lead_screw_length - the length of the lead screw.
 * @param Number lead_screw_lock_nut_height - the height of the lock nut on the lead screw.
 * @param Number lead_screw_washer_height - the height of the washer on the lead screw.
 */
function leg_sleeve_height(
    sleeve_depth = leg_sleeve_depth,
    plate_thickness = foot_plate_thickness,
    lead_screw_length = m8_screw_length,
    lead_screw_lock_nut_height = m8_screw_nut_lp_thickness,
    lead_screw_washer_height = m8_screw_washer_thickness,
) = (
    sleeve_depth +
    leg_sleeve_mount_height(
        plate_thickness=plate_thickness,
        lead_screw_length=lead_screw_length,
        lead_screw_lock_nut_height=lead_screw_lock_nut_height,
        lead_screw_washer_height=lead_screw_washer_height,
    )
);

/**
 * The width of a leg sleeve that can receive an adjustable leveling foot.
 * @param Number leg_width - the width of the leg that will fit into the sleeve.
 * @param Number sleeve_thickness - the thickness of the sleeve walls.
 */
function leg_sleeve_width(
    leg_width = table_leg_width,
    sleeve_thickness = leg_sleeve_thickness,
) = leg_width + sleeve_thickness * 2;

/**
 * The shape of a leg sleeve that can receive an adjustable leveling foot.
 * @param Number leg_width - the width of the leg that will fit into the sleeve.
 * @param Number leg_fillet_radius - the radius of the fillet on the leg.
 * @param Number sleeve_thickness - the thickness of the sleeve walls.
 * @param Number sleeve_depth - the depth of the sleeve.
 * @param Number sleeve_facets - the number of facets on the sleeve.
 * @param Number plate_thickness - the height of the plate that will receive the screw.
 * @param Number lead_screw_length - the length of the lead screw.
 * @param Number lead_screw_lock_nut_height - the height of the lock nut on the lead screw.
 * @param Number lead_screw_washer_height - the height of the washer on the lead screw.
 */
module leg_sleeve_body(
    leg_width = table_leg_width,
    leg_fillet_radius = table_leg_fillet_radius,
    sleeve_thickness = leg_sleeve_thickness,
    sleeve_depth = leg_sleeve_depth,
    sleeve_facets = leg_sleeve_facets,
    plate_thickness = foot_plate_thickness,
    lead_screw_length = m8_screw_length,
    lead_screw_lock_nut_height = m8_screw_nut_lp_thickness,
    lead_screw_washer_height = m8_screw_washer_thickness,
) {
    sleeve_width = leg_sleeve_width(
        leg_width=leg_width,
        sleeve_thickness=sleeve_thickness,
    );
    fillet_radius =leg_fillet_radius + sleeve_thickness;

    sleeve_height = leg_sleeve_height(
        sleeve_depth=sleeve_depth,
        plate_thickness=plate_thickness,
        lead_screw_length=lead_screw_length,
        lead_screw_lock_nut_height=lead_screw_lock_nut_height,
        lead_screw_washer_height=lead_screw_washer_height,
    );

    hull() {
        translateZ(sleeve_height - sleeve_depth) {
            cushion(size=[sleeve_width, sleeve_width, sleeve_depth], d=fillet_radius);
        }
        cylinder(d=sleeve_width, h=1, $fn=sleeve_facets);
    }
}

/**
 * A leg sleeve that can receive an adjustable leveling foot.
 * @param Number leg_width - the width of the leg that will fit into the sleeve.
 * @param Number leg_fillet_radius - the radius of the fillet on the leg.
 * @param Number sleeve_thickness - the thickness of the sleeve walls.
 * @param Number sleeve_depth - the depth of the sleeve.
 * @param Number sleeve_facets - the number of facets on the sleeve.
 * @param Number plate_thickness - the height of the plate that will receive the screw.
 * @param Number lead_screw_diameter - the diameter of the lead screw.
 * @param Number lead_screw_length - the length of the lead screw.
 * @param Number lead_screw_nut_size - the size of the nut that will receive the lead screw.
 * @param Number lead_screw_nut_height - the height of the nut on the lead screw.
 * @param Number lead_screw_lock_nut_height - the height of the lock nut on the lead screw.
 * @param Number lead_screw_washer_height - the height of the washer on the lead
 * @param Number lead_screw_washer_diameter - the diameter of the washer on the lead screw.
 * @param Number fastening_diameter - the diameter of the screw that will be used to fasten the sleeve to the leg.
 * @param Number fastening_head_diameter - the diameter of the head of the screw that will be used to fasten the sleeve to the leg.
 * @param Number fastening_offset - the distance from the edge of the sleeve to the center of the fastening screw hole.
 * @param Number fastening_height - the height of the fastening screw hole from the top of the sleeve.
 * @param Number adjust - a small value to adjust the dimensions of the holes to ensure proper fit.
 */
module leg_sleeve(
    leg_width = table_leg_width,
    leg_fillet_radius = table_leg_fillet_radius,
    sleeve_thickness = leg_sleeve_thickness,
    sleeve_depth = leg_sleeve_depth,
    sleeve_facets = leg_sleeve_facets,
    plate_thickness = foot_plate_thickness,
    lead_screw_diameter = m8_screw_diameter,
    lead_screw_length = m8_screw_length,
    lead_screw_nut_size = m8_screw_nut_hex_size,
    lead_screw_nut_height = m8_screw_nut_thickness,
    lead_screw_lock_nut_height = m8_screw_nut_lp_thickness,
    lead_screw_washer_height = m8_screw_washer_thickness,
    lead_screw_washer_diameter = m8_screw_washer_diameter,
    fastening_diameter = m3_screw_diameter,
    fastening_head_diameter = m3_screw_head_diameter,
    fastening_offset = leg_sleeve_fastening_offset,
    fastening_height = leg_sleeve_fastening_height,
    adjust = .1,
) {
    leg_mount_height = leg_sleeve_mount_height(
        plate_thickness=plate_thickness,
        lead_screw_length=lead_screw_length,
        lead_screw_lock_nut_height=lead_screw_lock_nut_height,
        lead_screw_washer_height=lead_screw_washer_height,
    );
    fastening_hole_offset = leg_width - fastening_offset;

    nut_pocket_height = adjustToLayerHeight(lead_screw_nut_height);
    washer_pocket_height = adjustToLayerHeight(lead_screw_washer_height);

    module _leg_sleeve_body() {
        leg_sleeve_body(
            leg_width=leg_width,
            leg_fillet_radius=leg_fillet_radius,
            sleeve_thickness=sleeve_thickness,
            sleeve_depth=sleeve_depth,
            sleeve_facets=sleeve_facets,
            plate_thickness=plate_thickness,
            lead_screw_length=lead_screw_length,
            lead_screw_lock_nut_height=lead_screw_lock_nut_height,
            lead_screw_washer_height=lead_screw_washer_height,
        );
    }
    module _leg_housing() {
        translateZ(leg_mount_height) {
            cushion(size=[leg_width, leg_width, sleeve_depth + 1], d=leg_fillet_radius);
        }
    }
    module _screw_hole() {
        translateZ(-1) {
            cylinder(h=lead_screw_length + 2, d=lead_screw_diameter + adjust);
        }
    }
    module _nut_hole() {
        translateZ(plate_thickness) {
            cylinder(h=nut_pocket_height + layer_height, d=circumradius(n=6, a=lead_screw_nut_size) + adjust, $fn=6);
            translateY(-(lead_screw_nut_size + adjust) / 2) {
                cube(size=[leg_width, lead_screw_nut_size + adjust, nut_pocket_height + layer_height]);
            }
            translateZ(nut_pocket_height) {
                cylinder(h=washer_pocket_height, d=lead_screw_washer_diameter + adjust);
                translateY(-(lead_screw_washer_diameter + adjust) / 2) {
                    cube(size=[leg_width, lead_screw_washer_diameter + adjust, washer_pocket_height]);
                }
            }
        }
    }
    module _fastening_hole() {
        repeat2D(
            countX=2,
            countY=2,
            intervalX=[fastening_hole_offset, 0],
            intervalY=[0, fastening_hole_offset],
            center=true
        ) {
            translateZ(-1) {
                cylinder(h=leg_mount_height + 2, d=fastening_diameter + adjust);
                cylinder(h=leg_mount_height - fastening_height + 1, d=fastening_head_diameter + adjust);
            }
        }
    }

    difference() {
        _leg_sleeve_body();
        _leg_housing();
        _screw_hole();
        _nut_hole();
        _fastening_hole();
    }
}
