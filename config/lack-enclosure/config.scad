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
 * Configuration file for the LACK enclosure project.
 *
 * @author jsconan
 */

// Part constraints.
leg_sleeve_thickness = 3;           // The thickness of the leg sleeve walls.
leg_sleeve_depth = 15;              // The depth of the leg sleeve.
leg_sleeve_facets = 8;              // The number of facets present on the sleeve at the bottom.
leg_sleeve_fastening_offset = 20;   // The distance from the edge of the sleeve to the center of the screw hole.
leg_sleeve_fastening_height = 10;   // The height of the fastening hole from the top of the sleeve.

foot_plate_thickness = 2;           // The thickness of the plate that will be tightened by the screw.

leveling_foot_screw_offset = 1;     // The distance from the screw head to the bottom.

// Print colors
leveling_foot_color = "#666";     // The color of the leveling foot.
leg_sleeve_color = "#222";        // The color of the leg sleeve.

// Printer settings.
layer_height = 0.2;             // The height of each layer in mm.

// Adjust a value to be a multiple of the layer height.
function adjustToLayerHeight(value) = roundBy(value + layer_height, layer_height);

// External part dimensions.
table_height = 450;             // The height of the LACK table.
table_width = 550;              // The width of the LACK table.
table_plate_thickness = 50;     // The thickness of the LACK table plate.
table_leg_height = 400;         // The height of the LACK table leg.
table_leg_width = 50;           // The width of the LACK table leg.
table_leg_fillet_radius = 3;    // The radius of the fillet on the LACK table leg.

m3_screw_diameter = 3;          // The diameter of the M3 screw.
m3_screw_length = 30;           // The length of the M3 screw.
m3_screw_head_diameter = 5.5;   // The diameter of the M3 screw head
m3_screw_head_thickness = 2.5;  // The thickness of the M3 screw head.

m8_screw_diameter = 8;          // The diameter of the M8 screw.
m8_screw_length = 35;           // The length of the M8 screw.
m8_screw_head_hex_size = 13;    // The size of the hexagonal head of the M8 screw.
m8_screw_head_thickness = 5.5;  // The thickness of the hexagonal head of the M8 screw.
m8_screw_nut_hex_size = 13;     // The size of the M8 hexagonal nut.
m8_screw_nut_thickness = 6.5;   // The thickness of the M8 hexagonal nut.
m8_screw_nut_lp_hex_size = 13;  // The size of the low-profile M8 hexagonal nut.
m8_screw_nut_lp_thickness = 4;  // The thickness of the low-profile M8 hexagonal nut.
m8_screw_washer_diameter = 24;  // The outer diameter of the M8 washer.
m8_screw_washer_thickness = 2;  // The thickness of the M8 washer.
