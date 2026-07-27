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
 * Part of the cross-circle fidget project.
 *
 * @author jsconan
 */

/**
 * Generates the cross-circle fidget based on the defined parameters and constraints.
 *
 * @param connectors The number of connectors to be placed around the circle.
 * @param base_diameter The base diameter of the cross-circle.
 */
module cross_circle(connectors=nb_connectors, base_diameter=base_diameter) {
    _radius = cross_circle_diameter(connectors=connectors, base_diameter=base_diameter) / 2;
    _connectors = cross_circle_connectors(connectors=connectors);

    _thickness = base_diameter / 5;
    _connector_depth = base_diameter / 6;
    _fillet_radius = base_diameter / 40;

    _inner_radius = circumradius(n=_connectors, a=_radius - _connector_depth - _thickness);
    _joint_radius = _connector_depth - _fillet_radius;
    _joint_angle = getChordAngle(length=_thickness / 2 + _fillet_radius, radius=_radius);
    _sector_angle = 360 / _connectors;

    // Computes the angles for the fillet of the connectors based on the index.
    function fillet_angles(i, start=0) =
        let(
            angle = _sector_angle * (i + 1),
            start_angle = angle - start,
            end_angle = angle - start + 90
        )
        start_angle < 360 && end_angle < 360
            ? [start_angle, end_angle]
            : start_angle > 360 && end_angle > 360
                ? [start_angle % 360, end_angle % 360]
                : [start_angle - 360, end_angle - 360]
    ;

    linear_extrude(height=_thickness, convexity=10) {
        difference() {
            polygon(points=path(concat([["P", arcp(r=_radius, a=_joint_angle)]], flatten(
                [
                    for (i = [0 : _connectors - 1])
                    let(
                        _start_angle = _sector_angle * i,
                        _end_angle = _sector_angle * (i + 1),
                        _first_fillet_angle = fillet_angles(i, 0),
                        _second_fillet_angle = fillet_angles(i, 90),
                    )
                    [
                        ["C", _radius, _start_angle + _joint_angle, _end_angle - _joint_angle],
                        ["C", _fillet_radius, _first_fillet_angle[0], _first_fillet_angle[1]],
                        ["A", _end_angle + 180, _joint_radius],
                        ["A", _end_angle + 90, _thickness],
                        ["A", _end_angle, _joint_radius],
                        ["C", _fillet_radius, _second_fillet_angle[0], _second_fillet_angle[1]],
                    ]
                ]
            ))));
            rotateZ(_sector_angle / 2) {
                circle(r=_inner_radius, $fn=_connectors);
            }
        }
    }
}

/**
 * Generates a plate of cross-circle fidgets based on the defined parameters and constraints.
 *
 * @param n The number of cross-circles to be placed on the plate.
 * @param connectors The number of connectors to be placed around each cross-circle.
 * @param margin The margin between the cross-circles.
 * @param line The max number of elements per lines. If not defined, it will be computed as the square root of `n`.
 * @param size The surrounding size of one cross-circle. This is used for interval between 2 cross-circles. If not defined, it will be computed based on the diameter of the cross-circle.
 * @param center Whether or not center the repeated shapes.
 */
module cross_circle_plate(
    n=4,
    connectors=nb_connectors,
    margin=inner_margin,
    line=undef,
    size=undef,
    center=true
) {
    space = (is_undef(size) ? cross_circle_diameter(connectors=connectors) : size) + margin;
    line = is_undef(line) ? floor(sqrt(n)) : line;
    repeatGrid(count=n, line=line, intervalX=[space, 0], intervalY=[0, space], center=center) {
         cross_circle(connectors=connectors);
    }
}
