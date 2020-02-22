#!/bin/bash
#
# GPLv3 License
#
# Copyright (c) 2019 Jean-Sebastien CONAN
#
# This file is part of jsconan/things.
#
# jsconan/things is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# jsconan/things is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with jsconan/things. If not, see <http://www.gnu.org/licenses/>.
#

#
# Generates the STL files for the tiny-whoops boxes.
#
# @author jsconan
#

# application params
whoop="tiny65bl"
boxX=
boxY=
drawerX=
drawerY=
drawers=

# script config
scriptpath=$(dirname $0)
project=$(pwd)
srcpath=${project}
dstpath=${project}/output

source "${scriptpath}/../../lib/camelSCAD/scripts/utils.sh"

# load parameters
while (( "$#" )); do
    case $1 in
        "-t"|"--whoop")
            whoop=$2
            shift
        ;;
        "-x")
            boxX=$2
            drawerX=$2
            shift
        ;;
        "-y")
            boxY=$2
            drawerY=$2
            shift
        ;;
        "-b"|"--box")
            boxX=$2
            boxY=$2
            shift
        ;;
        "-bx"|"--boxX")
            boxX=$2
            shift
        ;;
        "-by"|"--boxY")
            boxY=$2
            shift
        ;;
        "-d"|"--drawer")
            drawerX=$2
            drawerY=$2
            shift
        ;;
        "-dx"|"--drawerX")
            drawerX=$2
            shift
        ;;
        "-dy"|"--drawerY")
            drawerY=$2
            shift
        ;;
        "-ds"|"--drawers")
            drawers=$2
            shift
        ;;
        "-h"|"--help")
            echo -e "${C_INF}Renders OpenSCAD files${C_RST}"
            echo -e "  ${C_INF}Usage:${C_RST}"
            echo -e "${C_CTX}\t$0 [-h|--help] [-o|--option value] files${C_RST}"
            echo
            echo -e "${C_MSG}  -h,  --help         ${C_RST}Show this help"
            echo -e "${C_MSG}  -t,  --whoop        ${C_RST}Set the type of tiny-whoop (tiny65bl, tiny75bl)"
            echo -e "${C_MSG}  -x                  ${C_RST}Set the number of tiny-whoops in the length of a box and a drawer"
            echo -e "${C_MSG}  -y                  ${C_RST}Set the number of tiny-whoops in the width of a box and a drawer"
            echo -e "${C_MSG}  -b,  --box          ${C_RST}Set the number of tiny-whoops in both directions for a box"
            echo -e "${C_MSG}  -bx, --boxX         ${C_RST}Set the number of tiny-whoops in the length of a box"
            echo -e "${C_MSG}  -by, --boxY         ${C_RST}Set the number of tiny-whoops in the width of a box"
            echo -e "${C_MSG}  -d,  --drawer       ${C_RST}Set the number of tiny-whoops in both directions for a drawer"
            echo -e "${C_MSG}  -dx, --drawerX      ${C_RST}Set the number of tiny-whoops in the length of a drawer"
            echo -e "${C_MSG}  -dy, --drawerY      ${C_RST}Set the number of tiny-whoops in the width of a drawer"
            echo -e "${C_MSG}  -ds, --drawers      ${C_RST}Set the number of drawers"
            echo
            exit 0
        ;;
        *)
            ls $1 >/dev/null 2>&1
            if [ "$?" == "0" ]; then
                srcpath=$1
            else
                printerror "Unknown parameter ${1}"
            fi
        ;;
    esac
    shift
done

# check OpenSCAD
scadcheck

# render the files, if exist
scadrenderall "${srcpath}" "${dstpath}" "${whoop}" "" \
    "whoopType=\"${whoop}\"" \
    "$(vectorif "whoopCountBox" ${boxX} ${boxY})" \
    "$(vectorif "whoopCountDrawer" ${drawerX} ${drawerY})" \
    "$(varif "drawerCountCupboard" ${drawers})"
