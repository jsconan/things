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
 * Configures the project.
 *
 * @author jsconan
 */

projectVersion = "0.1.0";

// The dimensions and constraints of the elements
panelThickness = 23;            // The thickness of the panel the bracket must fit

rodWidth = 15;                  // The width of the rod
rodLength = 165;                // The length of a rod piece
rodDiameter = [8, 10];          // The diameter of the rounded part of the rod and the bracket
rodThickness = 6;               // The thickness of the rod

rodStopperWidth = 30;           // The width of the rod stoppers
rodStopperHeight = 30;          // The height of the rod stoppers
rodStopperDiameter = 20;        // The diameter of round part of the rod stoppers

rodSleeveThickness = 1;         // The thickness of the sleeve that will cover the rod at the link area
rodSleeveLength = 15;           // The length of a rod sleeve

rodBracketWidth = 10;           // The width of a bracket
rodBracketHeight = 30;          // The height of a bracket, including the rodThickness
rodBracketThickness = 2;        // The thickness of a bracket
rodBracketHookThickness = 0.6;  // The thickness of the hook that will clamp the panel
rodBracketHookHeight = 15;      // The height of the hook that will clamp the panel
