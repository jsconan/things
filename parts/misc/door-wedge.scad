/**
 * @license GPLv3 License
 * Copyright (c) 2023 Jean-Sebastien CONAN
 *
 * A wedge for aligning a door with its frame.
 *
 * Requires OpenSCAD for rendering the model, see https://openscad.org/
 */

// Defines the constraints for the object.
width = 100;            // overall width of the wedge
height = 15;            // overall height of the wedge
thicknessLeft = 3.5;    // thickness of the left side
thicknessRight = 3.7;   // thickness of the right side
screwDiameter = 3.2;    // outer diameter for the screw lead
screwHeadDiameter = 6;  // outer diameter for the screw head
screwHeadHeight = 2.7;  // the height of the screw head, from the top to the neck
screwHeadOffset = .6;   // the height of the screw head before the bevel
screws = 2;             // number of screws on the wedge

// Sets the rendering accuracy
$fa = .5;
$fs = .5;

// Defines an offset to avoid having a residual layer on difference
differenceAlignment = .1;

// Refines the  sizes
screwInterval = width / screws;
screwStart = -screwInterval * (screws - 1) / 2;
halfWidth = width / 2;
thickness = max(thicknessLeft, thicknessRight);
screwHeight = thickness - (screwHeadHeight + screwHeadOffset);
halfScrewDiameter = screwDiameter / 2;
halfScrewHeadDiameter = screwHeadDiameter / 2;

// Builds the wedge
difference() {
    // Wedge body
    rotate([90, 0, 0]) {
        linear_extrude(height = height, center = true, convexity = 10) {
            polygon(points = [
                [-halfWidth, 0],
                [halfWidth, 0],
                [halfWidth, thicknessRight],
                [-halfWidth, thicknessLeft],
            ]);
        }
    }

    // Screw holes
    for (i = [0 : max(0, screws - 1)]) {
        translate([screwStart + screwInterval * i, 0, 0]) {
            rotate_extrude(angle = 360, convexity = 10) {
                polygon(points=[
                    // Difference offset for making the object manifold
                    [0, -differenceAlignment],
                    [halfScrewDiameter, -differenceAlignment],

                    // Screw profile
                    [halfScrewDiameter, 0],
                    [halfScrewDiameter, screwHeight],
                    [halfScrewHeadDiameter, thickness - screwHeadOffset],
                    [halfScrewHeadDiameter, thickness],

                    // Difference offset for making the object manifold
                    [halfScrewHeadDiameter, thickness + differenceAlignment],
                    [0, thickness + differenceAlignment],
                ]);
            }
        }
    }
}
