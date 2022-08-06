#!/bin/bash
#
# GPLv3 License
#
# Copyright (c) 2022 Jean-Sebastien CONAN
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
# Generates the STL files for the project.
#
# @author jsconan
#

# script config
scriptpath="$(dirname $0)"
project="$(pwd)"
srcpath="${project}/parts"
dstpath="${project}/dist"
partsdir=
format=
parallel=
cleanUp=

# include libs
source "${scriptpath}/lib/camelSCAD/scripts/utils.sh"

# load parameters
while (( "$#" )); do
    case $1 in
        "-d"|"--dir")
            partsdir=$2
            shift
        ;;
        "-f"|"--format")
            format=$2
            shift
        ;;
        "-p"|"--parallel")
            parallel=$2
            shift
        ;;
        "-c"|"--clean")
            cleanUp=1
        ;;
        "-h"|"--help")
            echo -e "${C_INF}Renders OpenSCAD files${C_RST}"
            echo -e "  ${C_INF}Usage:${C_RST}"
            echo -e "${C_CTX}\t$0 [command] [-h|--help] [-o|--option value] files${C_RST}"
            echo
            echo -e "${C_MSG}  -h,  --help         ${C_RST}Show this help"
            echo -e "${C_MSG}  -d   --dir          ${C_RST}Select a particular parts directory to render"
            echo -e "${C_MSG}  -f   --format       ${C_RST}Set the output format"
            echo -e "${C_MSG}  -p   --parallel     ${C_RST}Set the number of parallel processes"
            echo -e "${C_MSG}  -c   --clean        ${C_RST}Clean up the output folder before rendering"
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

# defines the output format
scadformat "${format}"

# defines the number of parallel processes
scadprocesses "${parallel}"

# select a parts directory if needed
if [ "${partsdir}" != "" ]; then
    srcpath="${srcpath}/${partsdir}"
    dstpath="${dstpath}/${partsdir}"
    if [ ! -d "${srcpath}" ]; then
        printerror "There is no parts directory ${C_SEL}${srcpath}" E_NOTFOUND
    fi
fi

# makes sure the destination path exists
createpath "${dstpath}" "output" > /dev/null

# clean up the output
if [ "${cleanUp}" != "" ]; then
    printmessage "${C_CTX}Cleaning up the output folder"
    rm -rf "${dstpath}"
fi

scadrenderallrecurse "${srcpath}" "${dstpath}" "" "" --quiet
